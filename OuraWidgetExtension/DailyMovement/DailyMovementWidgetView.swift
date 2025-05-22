//
//  DailyMovementWidgetView.swift
//  OuraWidgetExtension
//
//  Created by Codegen on 2025-05-22.
//

import SwiftUI
import WidgetKit

struct DailyMovementWidgetView : View {
    var entry: DailyMovementWidgetProvider.Entry
    
    @Environment(\.widgetFamily) var family
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemMedium:
            DailyMovementWidgetMediumView(activity: entry.activity, errorMessage: entry.errorMessage)
        default:
            Text("Unsupported")
        }
    }
}

struct DailyMovementWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMovementWidgetView(entry: DailyMovementEntryPlaceholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

