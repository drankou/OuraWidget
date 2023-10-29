//
//  OuraService.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 08.01.2023.
//

import Foundation

struct CacheKey {
    static let activityEntry = "activity_entry"
    static let bedtimeEntry = "bedtime_entry"
    static let readinessEntry = "readiness_entry"
    static let sleepEntry = "sleep_entry"
    static let dailySleepEntry = "daily_sleep_entry"
}

final class OuraService {
    static let shared = OuraService()
    private let cache = UserDefaults.standard
    private init() {}
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    public func getActivity(apiKey: String) async -> DailyActivity? {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let currentDateString = dateFormatter.string(from: tomorrow)
        
        guard let url = URL(string: "https://api.ouraring.com/v2/usercollection/daily_activity?end_date=\(currentDateString)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        if let (data, _) = try? await URLSession.shared.data(for: request),
           let response = try? SnakeCaseJSONDecoder().decode(DailyActivityResponse.self, from: data),
           let dailyActivity = response.data.first {
            if let encodedData = try? SnakeCaseJSONEncoder().encode(dailyActivity) {
                cache.set(encodedData, forKey: CacheKey.activityEntry)
            }
            
            return dailyActivity
        }
        
        if let cachedData = cache.data(forKey: CacheKey.activityEntry),
           let dailyActivity = try? SnakeCaseJSONDecoder().decode(DailyActivity.self, from: cachedData) {
            return dailyActivity
        }
        
        return nil
    }
    
    public func getIdealBedtimeWindow(apiKey: String) async -> BedtimeWindow {
        let currentDate = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        
        let currentDateString = dateFormatter.string(from: currentDate)
        let yesterdayDateString = dateFormatter.string(from: yesterday)
        
        guard let url = URL(string: "https://api.ouraring.com/v1/bedtime?\(yesterdayDateString)&end=\(currentDateString)") else {
            return BedtimeWindow(status: .UNKNOWN, errorMessage: "Something went wrong. Check your API key")
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        if let (data, _) = try? await URLSession.shared.data(for: request),
           let response = try? JSONDecoder().decode(IdealBedtimeResponse.self, from: data),
           let idealBedtime = response.ideal_bedtimes.first {
            
            if idealBedtime.status == .IDEAL_BEDTIME_AVAILABLE {
                let bedtimeWindow = BedtimeWindow(start: idealBedtime.bedtime_window.start!,
                                                  end: idealBedtime.bedtime_window.end!,
                                                  status: idealBedtime.status)
                
                if let encodedData = try? SnakeCaseJSONEncoder().encode(bedtimeWindow) {
                    cache.set(encodedData, forKey: CacheKey.bedtimeEntry)
                }
                
                return bedtimeWindow
            }
            
            var errorMessage = ""
            switch idealBedtime.status {
                case .LOW_SLEEP_SCORES, .NOT_ENOUGH_DATA:
                    errorMessage = "Bedtime is not available. Try again later\nReason: \(idealBedtime.status.formatString())"
                case .UNKNOWN:
                    errorMessage = "Something went wrong. Try again later"
                default:
                    break
            }
            
            return BedtimeWindow(status: idealBedtime.status, errorMessage: errorMessage)
        }
        
        if let cachedData = cache.data(forKey: CacheKey.bedtimeEntry),
           let bedtimeWindow = try? SnakeCaseJSONDecoder().decode(BedtimeWindow.self, from: cachedData) {
            return bedtimeWindow
        }
        
        return BedtimeWindow(status: .UNKNOWN, errorMessage: "Something went wrong. Check your API key")
    }
    
    public func getDailyReadiness(apiKey: String) async -> DailyReadiness? {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let currentDateString = dateFormatter.string(from: tomorrow)
        
        guard let url = URL(string: "https://api.ouraring.com/v2/usercollection/daily_readiness?end_date=\(currentDateString)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        if let (data, _) = try? await URLSession.shared.data(for: request),
           let response = try? SnakeCaseJSONDecoder().decode(DailyReadinessResponse.self, from: data),
           let dailyReadiness = response.data.first {
            if let encodedData = try? SnakeCaseJSONEncoder().encode(dailyReadiness) {
                cache.set(encodedData, forKey: CacheKey.readinessEntry)
            }
            
            return dailyReadiness
        }
        
        if let cachedData = cache.data(forKey: CacheKey.readinessEntry),
           let dailyReadiness = try? SnakeCaseJSONDecoder().decode(DailyReadiness.self, from: cachedData) {
            return dailyReadiness
        }
        
        return nil
    }

    public func getSleep(apiKey: String) async -> Sleep? {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let currentDateString = dateFormatter.string(from: tomorrow)
        
        guard let url = URL(string: "https://api.ouraring.com/v2/usercollection/sleep?&end_date=\(currentDateString)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        
        if let (data, _) = try? await URLSession.shared.data(for: request),
           let response = try? SnakeCaseJSONDecoder().decode(SleepResponse.self, from: data),
           let sleep = response.data.first {
            if let encodedData = try? SnakeCaseJSONEncoder().encode(sleep) {
                cache.set(encodedData, forKey: CacheKey.sleepEntry)
            }
                        
            return sleep
        }
                
        if let cachedData = cache.data(forKey: CacheKey.sleepEntry),
           let sleep = try? SnakeCaseJSONDecoder().decode(Sleep.self, from: cachedData) {
            return sleep
        }
                
        return nil
    }
    
    public func getDailySleep(apiKey: String) async -> DailySleep? {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let currentDateString = dateFormatter.string(from: tomorrow)
        
        guard let url = URL(string: "https://api.ouraring.com/v2/usercollection/daily_sleep?&end_date=\(currentDateString)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        
        if let (data, _) = try? await URLSession.shared.data(for: request),
           let response = try? SnakeCaseJSONDecoder().decode(DailySleepResponse.self, from: data),
           let dailySleep = response.data.first {
            if let encodedData = try? SnakeCaseJSONEncoder().encode(dailySleep) {
                cache.set(encodedData, forKey: CacheKey.sleepEntry)
            }
                        
            return dailySleep
        }
                
        if let cachedData = cache.data(forKey: CacheKey.dailySleepEntry),
           let dailySleep = try? SnakeCaseJSONDecoder().decode(DailySleep.self, from: cachedData) {
            return dailySleep
        }
                
        return nil
    }
}
