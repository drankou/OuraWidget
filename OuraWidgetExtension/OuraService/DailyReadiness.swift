//
//  DailyReadiness.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

struct DailyReadinessResponse: Codable {
    let data: [DailyReadiness]
}


struct DailyReadiness: Codable {
    let score: Int
    let temperatureDeviation: Float
}

let DailyReadinessPlaceholder = DailyReadiness(
    score: 86,
    temperatureDeviation: -0.1
)
