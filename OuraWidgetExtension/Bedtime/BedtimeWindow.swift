//
//  BedtimeWindow.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import Foundation

struct IdealBedtimeResponse: Codable {
    let ideal_bedtimes: [IdealBedtime]
}

struct IdealBedtime: Codable {
    let date: String
    let bedtime_window: BedtimeWindowField
    let status: BedtimeWindowStatus
}

struct BedtimeWindowField: Codable {
    let start: Int?
    let end: Int?
}

enum BedtimeWindowStatus: String, Codable {
    case UNKNOWN = "UNKNOWN"
    case MISSING_API_KEY = "MISSING_API_KEY"
    case NOT_ENOUGH_DATA = "NOT_ENOUGH_DATA"
    case LOW_SLEEP_SCORES = "LOW_SLEEP_SCORES"
    case IDEAL_BEDTIME_AVAILABLE = "IDEAL_BEDTIME_AVAILABLE"
    
    func formatString() -> String {
        switch self {
        case .MISSING_API_KEY:
            return "Missing API key"
        case .UNKNOWN:
            return "Unknown"
        case .NOT_ENOUGH_DATA:
            return "Not enough data"
        case .LOW_SLEEP_SCORES:
            return "Low sleep scores"
        case .IDEAL_BEDTIME_AVAILABLE:
            return "Ideal bedtime available"
        }
    }
}

struct BedtimeWindowRich {
    struct Time {
        var hour: Int
        var minute: Int
    }
    
    var start: Time
    var end: Time
}

struct BedtimeWindow: Codable {
    var start: Int = 0
    var end: Int = 0
    var status: BedtimeWindowStatus = .UNKNOWN
    var isAvailable: Bool { status == .IDEAL_BEDTIME_AVAILABLE }
    var errorMessage: String = ""
    
    func formatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)!
        dateFormatter.setLocalizedDateFormatFromTemplate("HHmm")
        
        let startDate = Date(timeIntervalSince1970: TimeInterval(self.start))
        let endDate = Date(timeIntervalSince1970: TimeInterval(self.end))
        
        let startTimeString = dateFormatter.string(from: startDate)
        let endTimeString = dateFormatter.string(from: endDate)
        
        return "\(startTimeString) - \(endTimeString)"
    }
    
    func rich() -> BedtimeWindowRich {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        let startDate = Date(timeIntervalSince1970: TimeInterval(self.start))
        let endDate = Date(timeIntervalSince1970: TimeInterval(self.end))
        
        let startHour = calendar.component(.hour, from: startDate)
        let startMinute = calendar.component(.minute, from: startDate)
        
        let endHour = calendar.component(.hour, from: endDate)
        let endMinute = calendar.component(.minute, from: endDate)
        
        return BedtimeWindowRich(
            start: BedtimeWindowRich.Time(hour: toTwelveHourFormat(hour: startHour), minute: startMinute),
            end: BedtimeWindowRich.Time(hour: toTwelveHourFormat(hour: endHour), minute: endMinute)
        )
    }
}

func toTwelveHourFormat(hour: Int) -> Int {
    return hour > 12 ? hour - 12 : hour
}


let BedtimeWindowPlaceholder: BedtimeWindow = BedtimeWindow(start: -9000, end: -6300, status: .IDEAL_BEDTIME_AVAILABLE) //21:30 - 22:15
