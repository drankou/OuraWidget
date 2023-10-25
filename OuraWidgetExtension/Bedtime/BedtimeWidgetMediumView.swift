//
//  BedtimeWidgetMediumView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI
import WidgetKit

struct BedtimeWidgetMediumView: View {
    var bedtimeWindow: BedtimeWindow
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "moon")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    Text("Bedtime’s Approaching")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white) .textCase(.uppercase)
                    Spacer()
                }
                HStack(alignment: .center){
                    VStack (alignment: .leading, spacing: 8) {
                        if bedtimeWindow.isAvailable {
                            Text("Your optimal bedtime’s between:\n\(bedtimeWindow.formatString())")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top, 4)
                                .multilineTextAlignment(.leading)
                            
                            Text("It’s time to start winding down\nyour body and mind.")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(bedtimeWindow.errorMessage)
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.white)
                                .padding(.top, 16)
                        }
                    }
                    if bedtimeWindow.isAvailable {
                        Spacer()
                        ClockView(width: 90, bedtimeWindow: bedtimeWindow)
                    }
                }
                
                Spacer()
            }.padding(16)
        }.widgetBackground(backgroundView: BedtimeWidgetBackgroundView())
        .widgetURL(URL(string: Constants.DEEP_LINK + (bedtimeWindow.status == .MISSING_API_KEY ? "api_key" : "v1/route/home"))!)
    }
}

struct BedtimeWidgetMediumView_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeWidgetMediumView(bedtimeWindow: BedtimeWindowPlaceholder).previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
