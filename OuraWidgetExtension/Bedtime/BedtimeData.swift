//
//  BedtimeData.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import Foundation
import WidgetKit

struct BedtimeData: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let bedtimeWindow: BedtimeWindow
}


final class BedtimeDataProvider {
    static let shared = BedtimeDataProvider()
    private init() {}
    
    public func getIdealBedtimeWindow(apiKey: String) async -> BedtimeWindow? {
        let currentDate = Date()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: currentDate)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let currentDateString = dateFormatter.string(from: currentDate)
        let yesterdayDateString = dateFormatter.string(from: yesterday)

        let url = URL(string: "https://api.ouraring.com/v1/bedtime?\(yesterdayDateString)&end=\(currentDateString)")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        if let (data, _) = try? await URLSession.shared.data(for: request) {
            if let response = try? JSONDecoder().decode(IdealBedtimeResponse.self, from: data) {
                return response.ideal_bedtimes.first?.bedtime_window
            }
        }

        return BedtimeWindow()
    }
}
