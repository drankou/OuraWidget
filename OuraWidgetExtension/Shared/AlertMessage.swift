//
//  AlertMessage.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 29.10.2023.
//

import SwiftUI

struct AlertMessage: View {
    var message: String
    
    var body: some View {
        Text("\(message)")
            .padding(.vertical)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.white)
    }
}
