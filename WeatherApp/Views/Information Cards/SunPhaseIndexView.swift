//
//  SunPhaseIndexView.swift
//  WeatherApp
//
//  Created by Luka on 18.2.25..
//

import SwiftUI

struct SunPhaseIndexView: View {
    let header: String
    let valueDescription: String
    //let dayDuration: (sunrise: HourModel, sunset: HourModel)
    let _dayDuration: (sunrise: Double, sunset: Double)
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text(valueDescription)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            .padding()
            SunPositionView(_dayDuration: _dayDuration)
        }
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }
}

struct SunPositionView: View {
    @State private var stackWidth: CGFloat = 10
    @State private var stackHeight: CGFloat = 0
    
    @State private var horizonHeight: CGFloat = 0
    
    private let startOfDay = Calendar.current.startOfDay(for: Date()).timeIntervalSince1970
    
    //let dayDuration: (sunrise: HourModel, sunset: HourModel)
    let _dayDuration: (sunrise: Double, sunset: Double)
    
    var amplitude: CGFloat = 25
    
    var body: some View {
        ZStack {
            
            let sunrisePosX = (-horizonOffsetX())
            let sunrisePosXRelative = sunrisePosX * (2 * 3.14159)
            let sunrisePosY = cos(sunrisePosXRelative) * amplitude
            
            Wave()
                .stroke(.black.opacity(0.36), lineWidth: 6)
                .background(GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            stackWidth = geometry.size.width
                            stackHeight = geometry.size.height
                        }
                })
            Wave()
                .stroke(LinearGradient(colors: [.white.opacity(0.25), .white.opacity(0.75), .white.opacity(0.25)], startPoint: .leading, endPoint: .trailing), lineWidth: 6)
                .mask {
                    GeometryReader { innerProxy in
                        Rectangle()
                            .frame(width: innerProxy.size.width, height: (innerProxy.size.height / 2) - sunrisePosY)
                    }
                }
            Rectangle()
                .frame(height: 2.0)
                .foregroundStyle(.white)
                .offset(y: -sunrisePosY)
            
            let sunPosX = (sunPos() - middleOffsetX()) * stackWidth
            let sunPosXNormalized = sunPosX / (stackWidth / (2 * 3.14159))
            let sunPosY = (cos(sunPosXNormalized) * amplitude)
            
            Circle()
                .frame(width: 15)
                .foregroundStyle(.white)
                .glow(color: .white, radius: 15)
                .offset(x: sunPosX - (stackWidth / 2), y: sunPosY)
        }
    }
    
    func sunPos(_ time: HourModel? = nil) -> Double {
        //810 - default
        let resultingTime = time ?? HourModel.currTime()
        let dayIntervalNormalized = 1440.0
        let resultingTimeNormalized = HourModel.convertToMinutes(resultingTime.hour, resultingTime.minute)
        return (resultingTimeNormalized / dayIntervalNormalized)
    }
    
    func middleOffsetX() -> CGFloat {
        
        let sunrise = _dayDuration.sunrise
        let sunriseNormalized = (sunrise - startOfDay) / 60
        
        let sunset = _dayDuration.sunset
        let sunsetNormalized = (sunset - startOfDay) / 60
        
        let middleOfTheDay = (sunsetNormalized + sunriseNormalized) / 2
        let difference = middleOfTheDay - 720
        return difference / 1440.0
    }
    
    func horizonOffsetX() -> CGFloat {
        let sunrise = _dayDuration.sunrise
        //let sunriseNormalized = HourModel.convertToMinutes(sunrise.hour, sunrise.minute)
        let sunriseNormalized = (sunrise - startOfDay) / 60
        
        let sunset = _dayDuration.sunset
        let sunsetNormalized = (sunset - startOfDay) / 60
        
        let middleOfTheDay = (sunsetNormalized + sunriseNormalized) / 2
        return (middleOfTheDay - sunriseNormalized) / 1440.0
    }
    
    struct Wave: Shape {
        func path(in rect: CGRect) -> Path {
            let freq = 2 * 3.14159
            let amplitude = 25.0
            let width = rect.width
            let height = rect.height
            let waveLength = rect.width / CGFloat(freq)
            
            let startPoint: CGPoint = .init(x: rect.minX, y: (height / 2) + amplitude)
            let path = UIBezierPath()
            
            path.move(to: startPoint)
            
            for x in stride(from: 0, through: width, by: 1) {
                let relativeX = x / waveLength
                let y = (_math.cos(relativeX) * amplitude) + startPoint.y - amplitude
                let point = CGPoint(x: x, y: y)
                
                path.addLine(to: point)
            }
            
            return Path(path.cgPath)
        }
    }
}
