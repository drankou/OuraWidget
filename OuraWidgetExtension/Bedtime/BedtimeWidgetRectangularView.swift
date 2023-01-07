//
//  BedtimeWidgetRectangularView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI
import WidgetKit

struct BedtimeWidgetRectangularView: View {
    var bedtimeWindow: BedtimeWindow
    
    var body: some View {
        HStack (alignment: .center) {
            Image(systemName: "moon")
            VStack (alignment: .leading) {
                if bedtimeWindow.isAvailable {
                    Text("Ideal bedtime:\n\(bedtimeWindow.formatString())")
                } else {
                    Text("Bedtime is not available.")
                }
            }
        }.widgetURL(URL(string: Constants.DEEP_LINK + (bedtimeWindow.status == .MISSING_API_KEY ? "api_key" : ""))!)
    }
}


struct BedtimeWidgetRectangularView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            BedtimeWidgetRectangularView(bedtimeWindow: BedtimeWindowPlaceholder).previewContext(WidgetPreviewContext(family: .accessoryRectangular))
        } else {
            // Fallback on earlier versions
        }
    }
}
