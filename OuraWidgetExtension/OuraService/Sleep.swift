//
//  Sleep.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

import Foundation

struct SleepResponse: Codable {
    let data: [Sleep]
}

struct Sleep: Codable {
    let averageBreath: Double
    let averageHeartRate: Double
    let averageHrv: Int
    let deepSleepDuration: Int
    let lightSleepDuration: Int
    let remSleepDuration: Int
    let awakeTime: Int
    let timeInBed: Int
    let totalSleepDuration: Int
}

let SleepPlaceholder = Sleep(
    averageBreath: 14.523,
    averageHeartRate: 44.7,
    averageHrv: 97,
    deepSleepDuration: 7244,
    lightSleepDuration: 17230,
    remSleepDuration: 5160,
    awakeTime: 1234,
    timeInBed: 29634,
    totalSleepDuration: 30868
)
