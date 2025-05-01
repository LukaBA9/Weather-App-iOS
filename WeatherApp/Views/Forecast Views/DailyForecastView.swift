//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Luka on 9.2.25..
//

import SwiftUI

struct DailyForecastView: View {
    @EnvironmentObject var cityInformation: CityInformationViewModel
    
    @State private var range: (min: Double, max: Double) = (min: 100, max: -100)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("7-DAY FORECAST")
                .foregroundStyle(.white.opacity(0.6))
                .padding(.horizontal)
                .padding(.top, 10)
            VStack {
                ForEach(0..<7, id: \.self) { index in
                    let range = (min: Double(cityInformation.dailyForecast.temperature2mMin[index]), max: Double(cityInformation.dailyForecast.temperature2mMax[index]))
                    Divider()
                        .overlay(.white)
                        .padding(.bottom, 6)
                    WeatherForTheDay(currentTemperature: Int(cityInformation.currentForecast.temperature2m.rounded(.toNearestOrAwayFromZero)), isToday: index == 0 ? true : false, temperature: range, range: cityInformation.temperateRange, currentDay: (Global.shared.currentDay + index - 1) % 7)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 0.5)
    }
}

#Preview {
    DailyForecastView()
        .environmentObject(CityInformationViewModel())
}
