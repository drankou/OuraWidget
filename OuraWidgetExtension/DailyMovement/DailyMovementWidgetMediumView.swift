//
//  DailyMovementWidgetMediumView.swift
//  OuraWidgetExtension
//
//  Created by Codegen on 2025-05-22.
//

import SwiftUI
import WidgetKit

struct DailyMovementWidgetMediumView: View {
    var activity: DailyActivity? = DailyActivityPlaceholder
    var errorMessage: String = ""
    var isError: Bool { errorMessage != "" }
    
    // Activity levels
    let inactiveColor = Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.6))
    let lowColor = Color(#colorLiteral(red: 0.4, green: 0.7, blue: 0.9, alpha: 1.0))
    let mediumColor = Color(#colorLiteral(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0))
    let highColor = Color(#colorLiteral(red: 0.0, green: 0.3, blue: 0.8, alpha: 1.0))
    
    // Time labels
    let timeLabels = ["04", "08", "12", "16", "20", "00", "04"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                    Text("Daily movement")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .textCase(.uppercase)
                    Spacer()
                }
                
                if let activity = activity, let class5min = parseClass5Min(activity.class_5min) {
                    VStack(alignment: .leading, spacing: 8) {
                        ZStack(alignment: .topLeading) {
                            // Activity level labels on the right
                            VStack(alignment: .trailing, spacing: 0) {
                                Text("High")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(height: 25)
                                
                                Text("Medium")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(height: 25)
                                
                                Text("Low")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(height: 25)
                                
                                Text("Inactive")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(height: 25)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 10)
                            
                            // Horizontal grid lines
                            VStack(alignment: .leading, spacing: 0) {
                                Divider()
                                    .background(Color.white.opacity(0.3))
                                    .padding(.top, 25)
                                
                                Divider()
                                    .background(Color.white.opacity(0.3))
                                    .padding(.top, 25)
                                
                                Divider()
                                    .background(Color.white.opacity(0.3))
                                    .padding(.top, 25)
                                
                                Divider()
                                    .background(Color.white.opacity(0.3))
                                    .padding(.top, 25)
                            }
                            
                            // Activity bars
                            HStack(alignment: .bottom, spacing: 0) {
                                ForEach(0..<class5min.count, id: \.self) { index in
                                    ActivityBar(level: class5min[index])
                                        .frame(width: 2)
                                }
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 60) // Make room for labels
                        }
                        
                        // Time labels at the bottom
                        HStack(spacing: 0) {
                            ForEach(0..<timeLabels.count, id: \.self) { index in
                                Text(timeLabels[index])
                                    .font(.system(size: 10, weight: .regular))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.trailing, 60) // Align with the chart above
                    }
                } else {
                    if isError {
                        Text("\(errorMessage)")
                            .padding(.vertical)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.white)
                    } else {
                        Text("Daily movement data is not available right now.\nPlease check later.")
                            .padding(.vertical)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }.padding()
        }.widgetBackground(backgroundView: DailyMovementBackgroundView())
        .widgetURL(URL(string: Constants.DEEP_LINK + (isError ? "api_key" : "v1/route/activity")))
    }
    
    // Parse the class_5min string into an array of activity levels
    func parseClass5Min(_ class5min: String?) -> [Int]? {
        guard let class5min = class5min else { return nil }
        
        // Convert each character to an integer
        return class5min.compactMap { Int(String($0)) }
    }
}

struct ActivityBar: View {
    let level: Int
    
    var body: some View {
        VStack(spacing: 0) {
            if level >= 3 { // High
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.0, green: 0.3, blue: 0.8, alpha: 1.0)))
                    .frame(height: 25)
            } else {
                Rectangle().fill(Color.clear).frame(height: 25)
            }
            
            if level >= 2 { // Medium
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.2, green: 0.5, blue: 0.9, alpha: 1.0)))
                    .frame(height: 25)
            } else {
                Rectangle().fill(Color.clear).frame(height: 25)
            }
            
            if level >= 1 { // Low
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.4, green: 0.7, blue: 0.9, alpha: 1.0)))
                    .frame(height: 25)
            } else {
                Rectangle().fill(Color.clear).frame(height: 25)
            }
            
            // Inactive (always show)
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.6)))
                .frame(height: 25)
        }
    }
}

struct DailyMovementWidgetMediumView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMovementWidgetMediumView(activity: DailyActivityPlaceholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

