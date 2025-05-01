//
//  WeatherForTheDay.swift
//  WeatherApp
//
//  Created by Luka on 4.2.25..
//

import SwiftUI

struct WeatherForTheHour: View {
    let weatherState: WeatherState
    let temperature: Int
    let hour: Int
    let isDay: Bool
    var body: some View {
        VStack {
            Text(hour < 12 ? "\(hour) AM" : hour == 12 ? "\(hour) PM" : "\(hour-12) PM")
                .foregroundStyle(.white)
            Image(systemName: isDay ? WeatherComponents.shared.weatherIcons[weatherState]!.day : WeatherComponents.shared.weatherIcons[weatherState]!.night)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text("\(Int (temperature)) °\(false ? "F" : "C")")
                .foregroundStyle(.white)
        }
    }
}
