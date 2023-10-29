//
//  ReadinessEntry.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

import WidgetKit

struct ReadinessEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let readiness: Readiness?
    var errorMessage: String = ""
}

let ReadinessEntryPlaceholder: ReadinessEntry = ReadinessEntry(date: .now, configuration: ConfigurationIntent(), readiness: Readiness(dailyReadiness: DailyReadinessPlaceholder, sleep: SleepPlaceholder, dailySleep: DailySleepPlaceholder))
