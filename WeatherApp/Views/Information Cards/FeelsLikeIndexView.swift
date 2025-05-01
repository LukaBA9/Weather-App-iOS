//
//  FeelsLikeIndexView.swift
//  WeatherApp
//
//  Created by Luka on 19.2.25..
//

import SwiftUI

struct FeelsLikeIndexView: View {
    private let header: String = "Feels like"
    let value: Double
    let currTemp: Double
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text("\(value.formattedDescription)° \(Global.shared.isFahrenheit ? "F" : "C")")
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            Spacer()
            Text(abs(value - currTemp) > 1 ? value < currTemp ? "Wind is making it feel cooler" : "It feels warmer than the actual temperature" : "Similar to the actual temperature")
                .foregroundStyle(.white)
                .font(.system(size: 15, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        //.aspectRatio(0.941, contentMode: .fill)
        .padding()
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }
}
