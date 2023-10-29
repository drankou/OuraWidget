//
//  Score.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 29.10.2023.
//

import SwiftUI

struct Score: View {
    let score: Int
    var isCrown: Bool { score >= 85 }
    var scoreLabel: String {
        if score >= 85 {
            return "Optimal"
        } else if score >= 70 {
            return "Good"
        } else {
            return "Pay attention"
        }
    }
    
    var body: some View {
        HStack (alignment: .firstTextBaseline, spacing: 4) {
            Text("\(score)")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 0) {
                if isCrown {
                    Image("crown", bundle: Bundle(identifier: "com.drankou.OuraWidget.OuraWidgetExtension"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 8)
                }
                    
                Text(scoreLabel)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }
}
