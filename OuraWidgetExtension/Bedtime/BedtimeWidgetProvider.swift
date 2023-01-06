//
//  BedtimeWidgetProvider.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import WidgetKit
import KeychainAccess

struct BedtimeWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> BedtimeData {
        BedtimeData(date: Date(), configuration: ConfigurationIntent(), bedtimeWindow: BedtimeWindow(start: -9000, end: -6300))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (BedtimeData) -> ()) {
        let entry = BedtimeData(date: Date(), configuration: configuration, bedtimeWindow: BedtimeWindow(start: -9000, end: -6300))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<BedtimeData>) -> ()) {
        Task {
            let apiKey = try! KeychainHelper.shared.get(key: "OURA_API_KEY")!
            let bedtimeWindow = await BedtimeDataProvider.shared.getIdealBedtimeWindow(apiKey: apiKey)
            let entry = BedtimeData(date: .now, configuration: configuration, bedtimeWindow: bedtimeWindow ?? BedtimeWindow())
            let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15*60)))
            completion(timeline)
        }
    }
}
