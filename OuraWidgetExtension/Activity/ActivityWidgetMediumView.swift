//
//  ActivityWidgetMediumView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 05.01.2023.
//

import SwiftUI
import WidgetKit

struct ActivityWidgetMediumView: View {
    var activity: DailyActivity? = DailyActivityPlaceholder
    var errorMessage: String = ""
    var isError: Bool { errorMessage != "" }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "bolt")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                    Text("Activity")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .textCase(.uppercase)
                    Spacer()
                }
                
                if let activity = activity {
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 8) {
                            Score(score: activity.score)
                            HStack(alignment: .top, spacing: 16){
                                VStack(alignment: .leading, spacing: 8) {
                                    FieldValue(label: "Steps", value: "\(activity.steps)")
                                    FieldValue(label: "Walking equiv.", value: "\(formatMeters(activity.equivalentWalkingDistance))")
                                }
                                VStack(alignment: .leading, spacing: 8) {
                                    FieldValue(label: "Total burn", value: "\(activity.totalCalories) Cal")
                                    FieldValue(label: "Inactive time", value: "\(formatSeconds(activity.sedentaryTime))")
                                }
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        VStack (alignment: .leading, spacing: 8) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(activity.activeCalories)/\(activity.targetCalories)")
                                    .font(.system(size: 22, weight: .regular))
                                    .foregroundColor(.white)
                                    .padding(.top, 2)
                                    .overlay(alignment: .bottomLeading) {
                                        Text("Active calorie burn")
                                            .font(.system(size: 10, weight: .regular))
                                            .foregroundColor(.white)
                                            .opacity(0.6)
                                            .padding(.bottom, 24)
                                            .fixedSize()
                                    }
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                if (activity.metersToTarget > 0 ) {
                                    Text("You can reach your goal\nby walking \(formatMeters(activity.metersToTarget))")
                                        .frame(height: 26, alignment: .top)
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                } else {
                                    Text("You've reached your daily goal!")
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                        .padding(.leading, 16)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    if isError {
                        Text("\(errorMessage)")
                            .padding(.vertical)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.white)
                    } else {
                        Text("Activity overview is not available right now.\nPlease check later.")
                            .padding(.vertical)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }.padding()
        }.widgetBackground(backgroundView: ActivityBackgroundView())
        .widgetURL(URL(string: Constants.DEEP_LINK + (isError ? "api_key" : "v1/route/activity")))
    }
}

struct FieldValue: View {
    var label: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(label)")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.white)
                .opacity(0.6)
            Text("\(value)")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.white)
        }
    }
}

struct ActivityWidgetMediumView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityWidgetMediumView(activity: DailyActivityPlaceholder).previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

struct Score: View {
    let score: Int
    var isCrown: Bool { score >= 85 }
    var scoreLabel: String {
        if score >= 85 {
            return "Optimal"
        } else if score >= 70 {
            return "Good"
        } else {
            return "Pay attention"
        }
    }
    
    var body: some View {
        HStack (alignment: .firstTextBaseline, spacing: 4) {
            Text("\(score)")
                .font(.system(size: 24, weight: .regular))
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 0) {
                if isCrown {
                    Image("crown", bundle: Bundle(identifier: "com.drankou.OuraWidget.OuraWidgetExtension"))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 8)
                }
                    
                Text(scoreLabel)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }
}
