//
//  KeychainStorageWrapper.swift
//  OuraWidgetExtensionExtension
//
//  Created by Aliaksandr Drankou on 03.01.2023.
//

import SwiftUI
import KeychainAccess

@propertyWrapper
struct KeychainStorage: DynamicProperty {
    let key: String
    @State private var value: String
    
    init(wrappedValue: String = "", _ key: String) {
        self.key = key
        let initialValue = (try? KeychainHelper.shared.get(key: key)) ?? wrappedValue
        self._value = State<String>(initialValue: initialValue)
    }
    var wrappedValue: String {
        get  { value }
        
        nonmutating set {
            value = newValue
            do {
                try KeychainHelper.shared.set(key, value)
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    var projectedValue: Binding<String> {
        Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
    }
}
