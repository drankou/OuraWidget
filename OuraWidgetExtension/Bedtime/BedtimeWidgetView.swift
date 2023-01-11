//
//  BedtimeWidgetView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import WidgetKit
import SwiftUI
import Intents
import KeychainAccess

struct BedtimeWidgetView : View {
    var entry: BedtimeWidgetProvider.Entry
    
    @Environment(\.widgetFamily) var family
    @ViewBuilder
    var body: some View {
        switch family {
        case .accessoryInline:
            BedtimeWidgetAccessoryInlineView(bedtimeWindow: entry.bedtimeWindow)
        case .accessoryRectangular:
            BedtimeWidgetRectangularView(bedtimeWindow: entry.bedtimeWindow)
        case .systemSmall:
            BedtimeWidgetSmallView(bedtimeWindow: entry.bedtimeWindow)
        case .systemMedium:
            BedtimeWidgetMediumView(bedtimeWindow: entry.bedtimeWindow)
        default:
            Text("Unsupported")
        }
    }
}

struct BedtimeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeWidgetView(entry: BedtimeEntry(date: Date(), configuration: ConfigurationIntent(), bedtimeWindow: BedtimeWindowPlaceholder))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
