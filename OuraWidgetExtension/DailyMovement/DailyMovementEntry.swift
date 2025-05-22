//
//  DailyMovementEntry.swift
//  OuraWidgetExtension
//
//  Created by Codegen on 2025-05-22.
//

import WidgetKit

struct DailyMovementEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let activity: DailyActivity?
    var errorMessage: String = ""
}

let DailyMovementEntryPlaceholder: DailyMovementEntry = DailyMovementEntry(
    date: .now,
    configuration: ConfigurationIntent(),
    activity: DailyActivityPlaceholder
)

