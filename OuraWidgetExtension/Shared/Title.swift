//
//  Title.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 29.10.2023.
//

import SwiftUI

struct Title: View {
    var icon: String
    var title: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(.white)
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white) .textCase(.uppercase)
            Spacer()
        }
    }
}
