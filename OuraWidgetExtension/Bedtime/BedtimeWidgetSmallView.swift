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
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Title(icon: "moon", title: "Ideal Bedtime")
                }
                VStack {
                    if bedtimeWindow.isAvailable {
                        ClockView(bedtimeWindow: bedtimeWindow)
                        Text("\(bedtimeWindow.formatString())")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top, 4)
                    } else {
                        Text(bedtimeWindow.errorMessage)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                }
                Spacer()
            }.padding()
        }.widgetBackground(backgroundView: BedtimeWidgetBackgroundView())
        .widgetURL(URL(string: Constants.DEEP_LINK + (bedtimeWindow.status == .MISSING_API_KEY ? "api_key" : "v1/route/home"))!)
    }
}

struct BedtimeWidgetSmallView_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeWidgetSmallView(bedtimeWindow: BedtimeWindowPlaceholder).previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
