//
//  ReadinessWidgetProvider.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

import WidgetKit
import KeychainAccess

struct ReadinessWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ReadinessEntry {
        ReadinessEntry(date: Date(), configuration: ConfigurationIntent(), readiness: ReadinessPlaceholer)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (ReadinessEntry) -> ()) {
        let entry = ReadinessEntry(date: Date(), configuration: configuration, readiness: ReadinessPlaceholer)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<ReadinessEntry>) -> ()) {
        Task {
            var entry: ReadinessEntry
            
            if let apiKey = try? KeychainHelper.shared.get(key: "OURA_API_KEY"), apiKey != "" {
                let dailyReadiness = await OuraService.shared.getDailyReadiness(apiKey: apiKey)
                let sleep = await OuraService.shared.getSleep(apiKey: apiKey)
                let dailySleep = await OuraService.shared.getDailySleep(apiKey: apiKey)
                
                entry = ReadinessEntry(date: .now, configuration: configuration, readiness: Readiness(dailyReadiness: dailyReadiness, sleep: sleep, dailySleep: dailySleep))
            } else {
                entry = ReadinessEntry(date: .now, configuration: configuration, readiness: nil, errorMessage: "Missing API key.\nTap to configure")
            }

            let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15*60)))
            completion(timeline)
        }
    }
}
