//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Luka on 8.2.25..
//

import SwiftUI

struct HourlyForecastView: View {
    @EnvironmentObject var cityInformation: CityInformationViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("24-HOUR FORECAST")
                .foregroundStyle(.white.opacity(0.6))
                .padding(.horizontal)
                .padding(.top, 10)
            Divider()
                .overlay(.white)
                .padding(.horizontal)
            ScrollView(.horizontal) {
                HStack(spacing: 30) {
                    ForEach(0..<24, id: \.self) { index in
                        let hour: Int = (cityInformation.currHour + index)
                        let hourNormalized: Int = (cityInformation.currHour + index) % 24
                        let weather = weatherCodes[Int(cityInformation.hourlyForecast.weatherCode[hour])]!
                        let temp = Int(cityInformation.hourlyForecast.temperature2m[hour])
                        WeatherForTheHour(
                            weatherState: weather,
                            temperature: temp,
                            hour: hourNormalized, isDay: cityInformation.isDay(offset: Double(index))
                        )
                    }
                }
                .padding(15)
            }
        }
        .scrollIndicators(.never)
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 0.42)
    }
}
