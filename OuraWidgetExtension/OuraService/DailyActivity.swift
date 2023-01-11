//
//  DailyActivity.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 08.01.2023.
//

import Foundation

struct DailyActivityResponse: Codable {
  let data: [DailyActivity]
}

struct DailyActivity: Codable {
    let score: Int
    let activeCalories: Int
    let targetCalories: Int
    let totalCalories: Int
    let equivalentWalkingDistance: Int
    let metersToTarget: Int
    let sedentaryTime: Int
    let steps: Int
}

let DailyActivityPlaceholder = DailyActivity(
    score: 86,
    activeCalories: 320,
    targetCalories: 500,
    totalCalories: 2435,
    equivalentWalkingDistance: 5089,
    metersToTarget: 301,
    sedentaryTime: 3400,
    steps: 8001
)
