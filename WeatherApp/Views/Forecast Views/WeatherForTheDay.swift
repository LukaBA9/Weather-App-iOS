//
//  WeatherForTheDay.swift
//  WeatherApp
//
//  Created by Luka on 9.2.25..
//

import SwiftUI

struct WeatherForTheDay: View {
    let currentTemperature: Int
    let currentDay: Int
    let isToday: Bool
    var temperature: (min: Double, max: Double)
    var range: (min: Double, max: Double)
    
    @EnvironmentObject var cityInformation: CityInformationViewModel
    
    init(currentTemperature: Int, isToday: Bool, temperature: (min: Double, max: Double), range: (min: Double, max: Double), currentDay: Int) {
        self.currentTemperature = currentTemperature
        self.isToday = isToday
        self.temperature = temperature
        self.range = range
        self.currentDay = currentDay
    }
    
    var body: some View {
        let colors: [UIColor] = [.systemBlue, .systemYellow, .systemRed]
        HStack {
            Text(isToday ? "Today" : daysOfTheWeek[currentDay].rawValue)
                .foregroundStyle(.white)
                .frame(width: 50, alignment: .leading)
            Spacer()
            Image(systemName: WeatherComponents.shared.weatherIcons[weatherCodes[Int(cityInformation.dailyForecast.weatherCode[currentDay])]!]!.day)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 22)
            Spacer()
                .frame(maxWidth: 37)
            Text(temperature.min.formattedDescription)
                .foregroundStyle(.white).opacity(0.6)
                .frame(width: 40, alignment: .trailing)
            TemperatureBar(currentTemp: isToday ? currentTemperature : nil, minTemp: temperature.min.rounded(.toNearestOrAwayFromZero), maxTemp: temperature.max.rounded(.toNearestOrAwayFromZero), rangeMin: range.min.rounded(.toNearestOrAwayFromZero), rangeMax: range.max.rounded(.toNearestOrAwayFromZero), minColor: Color(colors.intermediate(percentage: (temperature.min + 5) / 70)), maxColor: Color(colors.intermediate(percentage: (temperature.max + 5) / 70)))
                .frame(width: 100, height: 10)
            Text(temperature.max.formattedDescription)
                .foregroundStyle(.white)
                .frame(width: 40, alignment: .trailing)
        }
    }
}
