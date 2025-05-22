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
    let class_5min: String?
}

let DailyActivityPlaceholder = DailyActivity(
    score: 86,
    activeCalories: 320,
    targetCalories: 500,
    totalCalories: 2435,
    equivalentWalkingDistance: 5089,
    metersToTarget: 301,
    sedentaryTime: 3400,
    steps: 8001,
    class_5min: "1112211111111111111111111111111111111111111111233322322223333323322222220000000000000000000000000000000000000000000000000000000233334444332222222222222322333444432222222221230003233332232222333332333333330002222222233233233222212222222223121121111222111111122212321223211111111111111111"
)
