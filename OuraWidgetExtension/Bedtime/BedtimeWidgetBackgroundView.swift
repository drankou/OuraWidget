//
//  BedtimeWidgetBackgroundView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI
import WidgetKit

struct BedtimeWidgetBackgroundView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(#colorLiteral(red: 0.18, green: 0.29, blue: 0.45, alpha: 1)))
                
            RoundedRectangle(cornerRadius: 20).fill(LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.30000001192092896)), location: 1)]),
                        startPoint: UnitPoint(x: 0.5, y: 1),
                        endPoint: UnitPoint(x: 0.5, y: 0)))
        }
    }
}

struct BedtimeWidgetBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeWidgetBackgroundView()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
