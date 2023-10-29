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
                    Title(icon: "bolt", title: "Activity")
                    Spacer()
                }
                
                if let activity = activity {
                    HStack(alignment: .top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 8) {
                            Score(score: activity.score)
                            HStack(alignment: .top, spacing: 16){
                                VStack(alignment: .leading, spacing: 8) {
                                    Field(label: "Steps", value: "\(activity.steps)")
                                    Field(label: "Walking equiv.", value: "\(formatMeters(activity.equivalentWalkingDistance))")
                                }
                                VStack(alignment: .leading, spacing: 8) {
                                    Field(label: "Total burn", value: "\(activity.totalCalories) Cal")
                                    Field(label: "Inactive time", value: "\(formatSeconds(activity.sedentaryTime))")
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
                        AlertMessage(message: errorMessage)
                    } else {
                        AlertMessage(message: "Activity overview is not available right now.\nPlease check later.")
                    }
                }
                Spacer()
            }.padding()
        }.widgetBackground(backgroundView: ActivityBackgroundView())
        .widgetURL(URL(string: Constants.DEEP_LINK + (isError ? "api_key" : "v1/route/activity")))
    }
}

struct ActivityWidgetMediumView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityWidgetMediumView(activity: DailyActivityPlaceholder).previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
