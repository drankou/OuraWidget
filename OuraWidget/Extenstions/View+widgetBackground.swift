//
//  View+widgetBackground.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 25.10.2023.
//

import SwiftUI

extension View {
    func widgetBackground(backgroundView: some View) -> some View {
        if #available(iOS 17.0, macCatalyst 17, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}

