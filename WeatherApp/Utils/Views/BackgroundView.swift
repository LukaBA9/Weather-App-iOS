//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Luka on 2.2.25..
//

import SwiftUI

struct BackgroundView: View {
    let weatherState: WeatherState
    var body: some View {
        //Display a random image that corresponds to the weather information passed
        Image(WeatherComponents.shared.backgroundImages[weatherState]!.randomElement()!)
            .ignoresSafeArea()
            .frame(width: 0, height: 0)
            .blur(radius: 9)
    }
}

#Preview {
    BackgroundView(weatherState: .clear)
}
