//
//  DailyMovementWidgetProvider.swift
//  OuraWidgetExtension
//
//  Created by Codegen on 2025-05-22.
//

import WidgetKit
import KeychainAccess

struct DailyMovementWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DailyMovementEntry {
        DailyMovementEntry(date: Date(), configuration: ConfigurationIntent(), activity: DailyActivityPlaceholder)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (DailyMovementEntry) -> ()) {
        let entry = DailyMovementEntry(date: Date(), configuration: configuration, activity: DailyActivityPlaceholder)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<DailyMovementEntry>) -> ()) {
        Task {
            var entry: DailyMovementEntry?
            
            if let apiKey = try? KeychainHelper.shared.get(key: "OURA_API_KEY"), apiKey != "" {
                let activity = await OuraService.shared.getActivity(apiKey: apiKey)
                entry = DailyMovementEntry(date: .now, configuration: configuration, activity: activity)
            } else {
                entry = DailyMovementEntry(date: .now, configuration: configuration, activity: nil, errorMessage: "Missing API key.\nTap to configure")
            }

            let timeline = Timeline(entries: [entry!], policy: .after(.now.advanced(by: 15*60)))
            completion(timeline)
        }
    }
}

