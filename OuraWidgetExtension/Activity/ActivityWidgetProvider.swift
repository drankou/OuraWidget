//
//  ActivityWidgetProvider.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import WidgetKit
import KeychainAccess

struct Person: Codable {
    var name: String
}

struct ActivityWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> ActivityEntry {
        ActivityEntry(date: Date(), configuration: ConfigurationIntent(), activity: DailyActivityPlaceholder)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (ActivityEntry) -> ()) {
        let entry = ActivityEntry(date: Date(), configuration: configuration, activity: DailyActivityPlaceholder)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<ActivityEntry>) -> ()) {
        Task {
            var entry: ActivityEntry?
            
            if let apiKey = try? KeychainHelper.shared.get(key: "OURA_API_KEY"), apiKey != "" {
                let activity = await OuraService.shared.getActivity(apiKey: apiKey)
                entry = ActivityEntry(date: .now, configuration: configuration, activity: activity)
            } else {
                entry = ActivityEntry(date: .now, configuration: configuration, activity: nil, errorMessage: "Missing API key.\nTap to configure")
            }

            let timeline = Timeline(entries: [entry!], policy: .after(.now.advanced(by: 10*60)))
            completion(timeline)
        }
    }
}
