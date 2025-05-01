//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Luka on 1.2.25..
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainInfoView()
                .environmentObject(CityInformationViewModel())
        }
    }
}
