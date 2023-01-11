//
//  Utils.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 08.01.2023.
//

import Foundation

class SnakeCaseJSONEncoder: JSONEncoder {
    override init() {
        super.init()
        keyEncodingStrategy = .convertToSnakeCase
    }
}

class SnakeCaseJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}

func formatMeters(_ meters: Int) -> String {
    let kilometers = Double(meters) / 1000.0
    let formatter = NumberFormatter()
    formatter.decimalSeparator = ","
    formatter.maximumFractionDigits = 1
    
    return formatter.string(for: kilometers)! + " km"
}

func formatSeconds(_ seconds: Int) -> String {
  let hours = seconds / 3600
  let minutes = (seconds % 3600) / 60
    
  return "\(hours)h \(minutes)m"
}
