//
//  ActivityWidgetView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import SwiftUI
import WidgetKit

struct ActivityWidgetView : View {
    var entry: ActivityWidgetProvider.Entry
    
    @Environment(\.widgetFamily) var family
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemMedium:
            ActivityWidgetMediumView(activity: entry.activity, errorMessage: entry.errorMessage)
        default:
            Text("Unsupported")
        }
    }
}


struct ActivityWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityWidgetView(entry: ActivityEntryPlaceholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
