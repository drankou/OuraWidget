//
//  SleepField.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 29.10.2023.
//

import SwiftUI

enum SleepType: String {
    case light = "Light"
    case rem = "REM"
    case deep = "Deep"
    case awake = "Awake"
}

struct SleepField: View {
    var duration: String
    var percentage: CGFloat
    var type: SleepType
    
    var body: some View {
        HStack(spacing: 4) {
            SleepRectangle(percentage: percentage, type: type)
            HStack(spacing: 0)  {
                Text("\(type.rawValue)")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.white)
                Text(" \(duration)")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.white)
                if type != .awake {
                    Text(" \(Int(percentage.rounded()))%")
                        .font(.system(size: 9))
                        .foregroundColor(Color(hex: "#C9C9C9"))
                }
            }
        }
    }
}

struct SleepRectangle: View {
    var percentage: CGFloat
    var type: SleepType
    
    var body: some View {
        GeometryReader { _ in
            Rectangle()
                .foregroundColor(colorForType(type))
                .cornerRadius(2)
        }
        .frame(width: min(percentage, 40))
    }
    
    private func colorForType(_ type: SleepType) -> Color {
        switch type {
        case .light:
            return Color(hex: "#578BBE")
        case .rem:
            return Color(hex: "8AD5FF")
        case .deep:
            return Color(hex: "27467B")
        case .awake:
            return Color(hex: "F2F3F5")
        }
    }
}
