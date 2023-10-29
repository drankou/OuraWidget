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

func formatMeters(_ meters: Int, isMetric: Bool = Locale.current.usesMetricSystem) -> String {
    let distance = isMetric ? Double(meters) / 1000.0 : Double(meters) * 0.000621371
    
    let formatter = NumberFormatter()
    formatter.decimalSeparator = ","
    formatter.maximumFractionDigits = isMetric ? 1 : 2
    
    if isMetric {
        return formatter.string(for: distance)! + " km"
    } else {
        return formatter.string(for: distance)! + " mi"
    }
}

func formatSeconds(_ seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    
    return "\(hours)h \(minutes)m"
}
