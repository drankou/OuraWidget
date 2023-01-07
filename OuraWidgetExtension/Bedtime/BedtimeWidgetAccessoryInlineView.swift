//
//  BedtimeWidgetAccessoryInlineView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI
import WidgetKit

struct BedtimeWidgetAccessoryInlineView: View {
    var bedtimeWindow: BedtimeWindow
    
    var body: some View {
        HStack {
            Image(systemName: "moon")
            if bedtimeWindow.isAvailable {
                Text("\(bedtimeWindow.formatString())")
            } else {
                Text("Bedtime is not available.")
            }
        }.widgetURL(URL(string: Constants.DEEP_LINK)!)
    }
}

struct BedtimeWidgetAccessoryInlineView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            BedtimeWidgetAccessoryInlineView(bedtimeWindow: BedtimeWindowTestData).previewContext(WidgetPreviewContext(family: .accessoryInline))
        } else {
            // Fallback on earlier versions
        }
    }
}
