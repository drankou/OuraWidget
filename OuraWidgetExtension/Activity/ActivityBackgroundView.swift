//
//  ActivityBackgroundView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import SwiftUI
import WidgetKit

struct ActivityBackgroundView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            .fill(Color(#colorLiteral(red: 0.19, green: 0.28, blue: 0.46, alpha: 1)))

            RoundedRectangle(cornerRadius: 20)
            .fill(RadialGradient(
                    gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.7833333015, green: 1, blue: 0.8439999819, alpha: 0.5)), location: 0),
                .init(color: Color(#colorLiteral(red: 0.38989585638046265, green: 0.5622707605361938, blue: 0.8208333253860474, alpha: 0.5)), location: 0.35),
                .init(color: Color(#colorLiteral(red: 0.11982640624046326, green: 0.15742716193199158, blue: 0.4958333373069763, alpha: 0.800000011920929)), location: 1)]),
                    center: UnitPoint(x: 0, y: 0),
                    startRadius: 10,
                    endRadius: 280
                  ))
        }
    }
}

struct ActivityBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityBackgroundView().previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
