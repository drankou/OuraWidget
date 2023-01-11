//
//  OuraService.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 08.01.2023.
//

import Foundation

let ACTIVITY_CACHE_ENTRY_KEY = "activity_entry"
let BEDTIME_CACHE_ENTRY_KEY = "bedtime_entry"

final class OuraService {
    static let shared = OuraService()
    private let cache = UserDefaults.standard
    private init() {}
    
    //TODO extract date format for API
    public func getActivity(apiKey: String) async -> DailyActivity? {
        let tomorrow = Calendar.current.date(byAdding: .day, value: +1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let currentDateString = dateFormatter.string(from: tomorrow)
        
        let url = URL(string: "https://api.ouraring.com/v2/usercollection/daily_activity?end_date=\(currentDateString)")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
                
        if let (data, _) = try? await URLSession.shared.data(for: request) {
            if let response = try? SnakeCaseJSONDecoder().decode(DailyActivityResponse.self, from: data) {
                if let dailyActivity = response.data.first {
                    if let encodedData = try? SnakeCaseJSONEncoder().encode(dailyActivity) {
                        cache.set(encodedData, forKey: ACTIVITY_CACHE_ENTRY_KEY)
                    }
                    return dailyActivity
                }
            }
        }
        
        if let cachedData = cache.data(forKey: ACTIVITY_CACHE_ENTRY_KEY) {
            if let dailyActivity = try? SnakeCaseJSONDecoder().decode(DailyActivity.self, from: cachedData) {
                return dailyActivity
            }
        }
        
        return nil
    }
    
    public func getIdealBedtimeWindow(apiKey: String) async -> BedtimeWindow {
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
                if let idealBedtime = response.ideal_bedtimes.first {
                    if idealBedtime.status == .IDEAL_BEDTIME_AVAILABLE {
                        let bedtimeWindow = BedtimeWindow(start: idealBedtime.bedtime_window.start!, end: idealBedtime.bedtime_window.end!, status: idealBedtime.status)
                        
                        if let encodedData = try? SnakeCaseJSONEncoder().encode(bedtimeWindow) {
                            cache.set(encodedData, forKey: BEDTIME_CACHE_ENTRY_KEY)
                        }
                        
                        return bedtimeWindow
                    }
                    
                    var errorMessage: String = ""
                    switch (idealBedtime.status) {
                    case .LOW_SLEEP_SCORES, .NOT_ENOUGH_DATA:
                        errorMessage = "Bedtime is not available. Try again later\nReason: \(idealBedtime.status.formatString())"
                    case .UNKNOWN:
                        errorMessage = "Something went wrong. Try again later"
                    default:
                        break
                    }
                    
                    return BedtimeWindow(status: idealBedtime.status, errorMessage: errorMessage)
                }
            }
        }
        
        
        if let cachedData = cache.data(forKey: BEDTIME_CACHE_ENTRY_KEY) {
            if let bedtimeWindow = try? SnakeCaseJSONDecoder().decode(BedtimeWindow.self, from: cachedData) {
                return bedtimeWindow
            }
        }

        return BedtimeWindow(status: .UNKNOWN, errorMessage: "Something went wrong. Check your API key")
    }
}
