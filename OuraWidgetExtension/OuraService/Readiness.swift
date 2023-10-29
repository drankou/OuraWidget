//
//  Readiness.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

import Foundation

struct Readiness: Codable {
    let dailyReadiness: DailyReadiness?
    let sleep: Sleep?
    let dailySleep: DailySleep?
}


let ReadinessPlaceholer = Readiness(dailyReadiness: DailyReadinessPlaceholder, sleep: SleepPlaceholder, dailySleep: DailySleepPlaceholder)
