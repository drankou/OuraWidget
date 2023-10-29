//
//  DailySleep.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 29.10.2023.
//

import Foundation

struct DailySleepResponse: Codable {
    let data: [DailySleep]
}

struct DailySleep: Codable {
    let score: Int
}

let DailySleepPlaceholder = DailySleep(score: 84)
