//
//  ClockView.swift
//  OuraWidgetExtension
//
//  Created by Aliaksandr Drankou on 02.01.2023.
//

import SwiftUI
import WidgetKit

struct ClockView: View {
    var width:CGFloat = 80
    var bedtimeWindow: BedtimeWindow
    let isTwelveHourCycle = Calendar.current.locale?.hourCycle == .oneToTwelve
    let currentHour = CGFloat(Calendar.current.component(.hour, from: Date()))
    let currentMinutes = CGFloat(Calendar.current.component(.minute, from: Date()))
    var window: BedtimeWindowRich { bedtimeWindow.rich() }
    var startMinutes: Double { window.start.hour.doubleValue*60 + window.start.minute.doubleValue }
    var endMinutes: Double { window.end.hour.doubleValue*60 + window.end.minute.doubleValue }
    
    var body: some View {
        VStack {
            ZStack {
                // Clock base
                ZStack{
                    Circle()
                        .fill(.black)
                    
                    Circle()
                        .strokeBorder(Color(hex: "568BBE"), lineWidth: 3)
                    
                    CircleSector(startAngle: .degrees(startMinutes*0.5-90), endAngle: .degrees(endMinutes*0.5-90), radius: width/2)
                        .opacity(0.2)
                    
                    let arcLength:CGFloat = 0.001388*((window.end.hour.doubleValue < window.start.hour.doubleValue ? endMinutes + 720 : endMinutes)-startMinutes)
                    Circle()
                        .trim(from: 0, to: arcLength)
                        .stroke(
                            .white,
                            lineWidth: 3
                        )
                        .rotationEffect(.degrees(startMinutes*0.5-90))
                }
                
                // Hour arrow
                Circle()
                    .fill(.white)
                    .frame(width: 2, height: 2)
                Rectangle()
                    .fill(.white)
                    .cornerRadius(20)
                    .frame(width: 2, height: (width-20) / 2)
                    .offset(y: -(width-20)/4)
                    .rotationEffect(.degrees(30*currentHour+currentMinutes/2))
                    .zIndex(1)
                
                // Hours ticks
                ForEach(0..<12, id: \.self) { i in
                    let size:CGFloat = (i % 3) == 0 ? 3 : 1
                    Circle()
                        .fill(Color.white)
                        .frame(width: size, height: size)
                        .offset(y: -CGFloat(width/2-6))
                        .rotationEffect(.init(degrees: Double(i) * 30))
                }
                
                ZStack {
                    HStack {
                        ClockHour(value: isTwelveHourCycle ? "9" : "21")
                        Spacer()
                        ClockHour(value: isTwelveHourCycle ? "3" : "15")
                    }
                    VStack {
                        ClockHour(value: isTwelveHourCycle ? "12" : "0")
                        Spacer()
                        ClockHour(value: isTwelveHourCycle ? "6" : "18")
                    }
                }.frame(width: width, height: width)
            }.frame(width: width, height: width)
        }
    }
    
}

struct CircleSector: View {
    var startAngle: Angle
    var endAngle: Angle
    var radius: CGFloat
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: radius, y: radius))
            path.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            path.closeSubpath()
        }.foregroundColor(.white)
    }
}

struct ClockHour: View {
    let value: String
    
    var body: some View {
        Text(value)
            .foregroundColor(.gray)
            .font(.system(size: 8, weight: .semibold))
            .padding(10)
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(bedtimeWindow: BedtimeWindowTestData).previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
