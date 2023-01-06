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
    let bedtime_window: BedtimeWindow
    let status: String
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
    var isAvailable: Bool {
        start != 0 && end != 0
    }
    
    func formatString() -> String {
        let locale = Calendar.current.locale
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = locale?.hourCycle == .oneToTwelve ? "h:mm a" : "HH:mm"
        dateFormatter.timeZone = locale?.timeZone ?? TimeZone(secondsFromGMT: 0)
        
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


let BedtimeWindowTestData: BedtimeWindow = BedtimeWindow(start: -9000, end: -6300) //21:30 - 22:15
