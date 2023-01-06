//
//  OuraWidgetApp.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI

@main
struct OuraWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class SharedState: ObservableObject {
    @Published var isRedirectPage: Bool
    init(isRedirectPage: Bool) {
        self.isRedirectPage = isRedirectPage
    }
}
