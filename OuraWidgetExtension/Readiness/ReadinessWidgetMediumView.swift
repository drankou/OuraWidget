//
//  ReadinessWidgetMediumView.swift
//  OuraWidget
//
//  Created by Aliaksandr Drankou on 28.10.2023.
//

import SwiftUI
import WidgetKit

struct ReadinessWidgetMediumView: View {
    var readiness: Readiness? = ReadinessPlaceholer
    var errorMessage: String = ""
    var isError: Bool { errorMessage != "" }
    
    var bodyTemp: String {
        if let dailyReadiness = readiness?.dailyReadiness {
            let value = ceil(dailyReadiness.temperatureDeviation * 10) / 10.0
            let sign = value > 0 ? "+" : ""
            
            return "\(sign)\(value) °C"
        }
        
        return "0.0 °C"
    }
    
    var body: some View {
        ZStack {
            if let readiness = readiness, let sleep = readiness.sleep, let dailyReadiness = readiness.dailyReadiness, let dailySleep = readiness.dailySleep {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Title(icon: "leaf", title: "Readiness")
                            Score(score: dailyReadiness.score)
                            HStack(alignment: .top, spacing: 16){
                                VStack(alignment: .leading, spacing: 8) {
                                    Field(label: "Resting HR", value: "\(Int(sleep.averageHeartRate.rounded())) bpm")
                                    Field(label: "Body temp.", value: bodyTemp)
                                }
                                VStack(alignment: .leading, spacing: 8) {
                                    Field(label: "HRV", value: "\(sleep.averageHrv) ms")
                                    Field(label: "Resp. rate", value: "\(ceil(sleep.averageBreath*10)/10.0) / min")
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Title(icon: "moon", title: "Sleep")
                            Score(score: dailySleep.score)
                            VStack(alignment: .leading, spacing: 4){
                                SleepField(duration: formatSeconds(sleep.awakeTime), percentage: CGFloat(sleep.awakeTime)/CGFloat(sleep.timeInBed)*100, type: .awake)
                                SleepField(duration: formatSeconds(sleep.remSleepDuration), percentage: CGFloat(sleep.remSleepDuration)/CGFloat(sleep.totalSleepDuration)*100, type: .rem)
                                SleepField(duration: formatSeconds(sleep.lightSleepDuration), percentage: CGFloat(sleep.lightSleepDuration)/CGFloat(sleep.totalSleepDuration)*100, type: .light)
                                SleepField(duration: formatSeconds(sleep.deepSleepDuration), percentage: CGFloat(sleep.deepSleepDuration)/CGFloat(sleep.totalSleepDuration)*100, type: .deep)
                            }
                        }.padding([.leading], 16)
                    }
                    Spacer()
                }.padding()
            } else {
                if isError {
                    AlertMessage(message: errorMessage)
                } else {
                    AlertMessage(message: "Readiness overview is not available right now.\nPlease check later.")
                }
            }
        }.widgetBackground(backgroundView: ReadinessBackgroundView())
            .widgetURL(URL(string: Constants.DEEP_LINK + "v1/route/readiness")!)
    }
}

struct ReadinessWidgetMediumView_Previews: PreviewProvider {
    static var previews: some View {
        ReadinessWidgetMediumView(readiness: ReadinessPlaceholer).previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
