//
//  TemperatureBar.swift
//  WeatherApp
//
//  Created by Luka on 10.2.25..
//

import SwiftUI

struct TemperatureBar: View {
    var currentTemp: Int?
    let minTemp: Double
    let maxTemp: Double
    let rangeMin: Double
    let rangeMax: Double
    let minColor: Color
    let maxColor: Color
    
    var body: some View {
            GeometryReader { geometry in
                let totalWidth = geometry.size.width
                let start = CGFloat((minTemp - rangeMin) / (rangeMax - rangeMin)) * totalWidth
                let end = CGFloat((maxTemp - rangeMin) / (rangeMax - rangeMin)) * totalWidth
                let barWidth = end - start
                
                let gradient = LinearGradient(colors: [minColor, maxColor], startPoint: .leading, endPoint: .trailing)

                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                        .fill(Color.blue.opacity(0.3))
                        .frame(height: 8)

                    RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                        .fill(gradient)
                        .frame(width: barWidth, height: 8)
                        .offset(x: start)
                    if let currentTemp = self.currentTemp {
                        Circle().fill(.white)
                            .frame(width: 8, height: 8)
                            .offset(x: CGFloat((Double(currentTemp) - rangeMin) / (rangeMax - rangeMin)) * totalWidth - 4)
                    }
                }
            }
            .frame(height: 10)
        }
}

#Preview {
    TemperatureBar(currentTemp: 10, minTemp: 5, maxTemp: 15, rangeMin: 0, rangeMax: 18, minColor: .green, maxColor: .yellow)
}
