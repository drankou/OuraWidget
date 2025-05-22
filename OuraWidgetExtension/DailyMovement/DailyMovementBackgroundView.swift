//
//  DailyMovementBackgroundView.swift
//  OuraWidgetExtension
//
//  Created by Codegen on 2025-05-22.
//

import SwiftUI
import WidgetKit

struct DailyMovementBackgroundView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            .fill(Color(#colorLiteral(red: 0.05, green: 0.10, blue: 0.20, alpha: 1)))

            RoundedRectangle(cornerRadius: 20)
            .fill(RadialGradient(
                    gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.5)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.05, green: 0.1, blue: 0.2, alpha: 0.8)), location: 0.5),
                .init(color: Color(#colorLiteral(red: 0.02, green: 0.05, blue: 0.1, alpha: 1.0)), location: 1)]),
                    center: UnitPoint(x: 0.5, y: 0.5),
                    startRadius: 10,
                    endRadius: 280
                  ))
        }
    }
}

struct DailyMovementBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMovementBackgroundView().previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

