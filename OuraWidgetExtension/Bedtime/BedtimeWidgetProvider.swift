//
//  BedtimeWidgetProvider.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import WidgetKit
import KeychainAccess

struct BedtimeWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> BedtimeEntry {
        BedtimeEntry(date: Date(), configuration: ConfigurationIntent(), bedtimeWindow: BedtimeWindowPlaceholder)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (BedtimeEntry) -> ()) {
        let entry = BedtimeEntry(date: Date(), configuration: configuration, bedtimeWindow: BedtimeWindowPlaceholder)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<BedtimeEntry>) -> ()) {
        Task {
            var bedtimeWindow: BedtimeWindow
            
            if let apiKey = try? KeychainHelper.shared.get(key: "OURA_API_KEY"), apiKey != "" {
                bedtimeWindow = await OuraService.shared.getIdealBedtimeWindow(apiKey: apiKey)
            } else {
                bedtimeWindow = BedtimeWindow(status: .MISSING_API_KEY, errorMessage: "Tap to configure API key")
            }
            
            let entry = BedtimeEntry(date: .now, configuration: configuration, bedtimeWindow: bedtimeWindow)
            let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 30*60)))
            completion(timeline)
        }
    }
}
