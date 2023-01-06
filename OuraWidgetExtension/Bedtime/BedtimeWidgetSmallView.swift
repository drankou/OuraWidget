//
//  BedtimeWidgetSmallView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI
import WidgetKit

struct BedtimeWidgetSmallView: View {
    var bedtimeWindow: BedtimeWindow
    
    var body: some View {
        ZStack {
            BedtimeWidgetBackgroundView()
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Image(systemName: "moon")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                    Text("Ideal Bedtime")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white) .textCase(.uppercase)
                }
                VStack {
                    if bedtimeWindow.isAvailable {
                        ClockView(bedtimeWindow: bedtimeWindow)
                        Text("\(bedtimeWindow.formatString())")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top, 4)
                    } else {
                        Text("Bedtime window is not available yet. Please check later")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                }
                Spacer()
            }.padding()
        }.widgetURL(URL(string: Constants.DEEP_LINK)!)
    }
}

struct BedtimeWidgetSmallView_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeWidgetSmallView(bedtimeWindow: BedtimeWindowTestData).previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
