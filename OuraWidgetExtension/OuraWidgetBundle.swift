//
//  OuraWidgetBundle.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import WidgetKit
import SwiftUI

@main
struct OuraWidgetBundle: WidgetBundle {
    var body: some Widget {
        BedtimeWidget()
        ActivityWidget()
    }
}

struct BedtimeWidget: Widget {
    let kind: String = "BedtimeWidget"
    
    private var supportedFamilies: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [
                .systemSmall,
                .systemMedium,
                .accessoryRectangular,
                .accessoryInline
            ]
        } else {
            return [
                .systemSmall,
                .systemMedium,
            ]
        }
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: BedtimeWidgetProvider()) { entry in
            BedtimeWidgetView(entry: entry)
        }
        .configurationDisplayName("Bedtime")
        .description("Get quick insight about your ideal bedtime.")
        .supportedFamilies(supportedFamilies)
        .contentMarginsDisabled()
    }
}

struct ActivityWidget: Widget {
    let kind: String = "ActivityWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: ActivityWidgetProvider()) { entry in
            ActivityWidgetView(entry: entry)
        }
        .configurationDisplayName("Activity")
        .description("Get quick insights about your Activity score.")
        .supportedFamilies([.systemMedium])
        .contentMarginsDisabled()
    }
}
