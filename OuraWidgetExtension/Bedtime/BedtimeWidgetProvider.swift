//
//  BedtimeWidgetProvider.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import WidgetKit
import KeychainAccess


class BedtimeEntryCache {
    var previousEntry: BedtimeData?
}

struct BedtimeWidgetProvider: IntentTimelineProvider {
    private let entryCache = BedtimeEntryCache()
    
    func placeholder(in context: Context) -> BedtimeData {
        BedtimeData(date: Date(), configuration: ConfigurationIntent(), bedtimeWindow: BedtimeWindowPlaceholder)
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (BedtimeData) -> ()) {
        let entry = BedtimeData(date: Date(), configuration: configuration, bedtimeWindow: BedtimeWindowPlaceholder)
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<BedtimeData>) -> ()) {
        Task {
            var bedtimeWindow: BedtimeWindow
            
            if let apiKey = try? KeychainHelper.shared.get(key: "OURA_API_KEY"), apiKey != "" {
                bedtimeWindow = await BedtimeDataProvider.shared.getIdealBedtimeWindow(apiKey: apiKey)
            } else {
                bedtimeWindow = BedtimeWindow(status: .MISSING_API_KEY, errorMessage: "Tap to configure API key")
            }
            
            if let cachedEntry = entryCache.previousEntry, !bedtimeWindow.isAvailable {
                let timeline = Timeline(entries: [cachedEntry], policy: .after(.now.advanced(by: 60*60)))
                completion(timeline)
                return
            }
            
            let entry = BedtimeData(date: .now, configuration: configuration, bedtimeWindow: bedtimeWindow)
            if bedtimeWindow.isAvailable {
                entryCache.previousEntry = entry
            }
            let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 60*60)))
            completion(timeline)
        }
    }
}
