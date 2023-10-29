//
//  ReadinessWidgetView.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

import SwiftUI
import WidgetKit

struct ReadinessWidgetView : View {
    var entry: ReadinessWidgetProvider.Entry
    
    @Environment(\.widgetFamily) var family
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemMedium:
            ReadinessWidgetMediumView(readiness: entry.readiness, errorMessage: entry.errorMessage)
        default:
            Text("Unsupported")
        }
    }
}


struct ReadinessWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ReadinessWidgetView(entry: ReadinessEntryPlaceholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
