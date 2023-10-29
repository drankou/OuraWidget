//
//  ReadinessBackgroundView.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

import SwiftUI
import WidgetKit

struct ReadinessBackgroundView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "003A90"))
            
            RoundedRectangle(cornerRadius: 20)
                .fill(RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(hex: "FFB9DB"), location: 0),
                        .init(color: Color(UIColor(red: 1, green: 1, blue: 1, alpha: 0.03)), location: 1)]),
                    center: UnitPoint(x: 0.5, y: 1.5),
                    startRadius: 5,
                    endRadius: 220
                ))
        }
    }
}

struct ReadinessBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ReadinessBackgroundView().previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
