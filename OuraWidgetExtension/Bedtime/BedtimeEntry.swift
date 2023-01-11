//
//  BedtimeEntry.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import Foundation
import WidgetKit

struct BedtimeEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let bedtimeWindow: BedtimeWindow
}
