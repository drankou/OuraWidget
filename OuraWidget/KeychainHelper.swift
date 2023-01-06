//
//  KeychainHelper.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import Foundation
import KeychainAccess

final class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}
    
    let service = "7R6HKL95CT.com.drankou.OuraWidget.shared"
    let accessGroup = "group.com.drankou.OuraWidget.shared"
    
    func set(_ key: String, _ value: String) throws {
        let keychain = Keychain(service: service, accessGroup: accessGroup)
        try keychain.set(value, key: key)
    }
    
    func get(key: String) throws -> String? {
        let keychain = Keychain(service: service, accessGroup: accessGroup)
        return try keychain.getString(key)
    }
}
