//
//  ActivityData.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import WidgetKit

struct ActivityEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let activity: DailyActivity?
    var errorMessage: String = ""
}

let ActivityEntryPlaceholder:ActivityEntry = ActivityEntry(date: .now, configuration: ConfigurationIntent(), activity: DailyActivityPlaceholder)
