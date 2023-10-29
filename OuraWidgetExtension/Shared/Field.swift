//
//  Field.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 29.10.2023.
//

import SwiftUI

struct Field: View {
    var label: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            FieldLabel(label: "\(label)")
            FieldValue(value: "\(value)")
        }
    }
}

struct FieldLabel: View {
    var label: String
    
    var body: some View {
        Text("\(label)")
            .font(.system(size: 10, weight: .medium))
            .foregroundColor(.white)
            .opacity(0.6)
    }
}

struct FieldValue: View {
    var value: String
    
    var body: some View {
            Text("\(value)")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.white)
    }
}
