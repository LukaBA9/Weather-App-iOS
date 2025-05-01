//
//  CityRowView.swift
//  WeatherApp
//
//  Created by Luka on 27.4.25..
//

import SwiftUI

struct CityRowView: View {
    let city: City
    let updateCurrCity: () -> Void
    var body: some View {
        Button {
            updateCurrCity()
        } label: {
            HStack {
                Text("\(city.cityName), \(city.countryCode)")
                Spacer()
            }
            .padding()
            .background(.white, in: Capsule())
            .shadow(color: .black.opacity(0.15), radius: 10)
            .padding()
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    CityRowView(city: DeveloperPreview.shared.cities.first!, updateCurrCity: {})
}
