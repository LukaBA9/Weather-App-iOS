//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Luka on 2.2.25..
//

import Foundation

enum WeatherState {
    case clear
    case mainlyClear
    case partlyCloudy
    case overcast
    case fog
    case rain
    case snow
    case thunderstorm
    
}

let weatherCodes: [Int: WeatherState] = [
    0: .clear,
    1: .mainlyClear,
    2: .partlyCloudy,
    3: .overcast,
    45: .fog,
    48: .fog,
    51: .rain,
    53: .rain,
    55: .rain,
    56: .rain,
    57: .rain,
    61: .rain,
    63: .rain,
    65: .rain,
    66: .rain,
    67: .rain,
    71: .snow,
    73: .snow,
    75: .snow,
    77: .snow,
    80: .rain,
    81: .rain,
    82: .rain,
    85: .snow,
    86: .snow,
    95: .thunderstorm,
    96: .thunderstorm,
    99: .thunderstorm
    ]

struct WeatherComponents {
    static var shared: WeatherComponents = WeatherComponents()
    
    enum temperatureDescription: String {
        case very_cold = "Very cold"
        case cold = "Cold"
        case normal = "Normal"
        case warm = "Warm"
        case hot = "Hot"
    }
    
    let backgroundImages: [WeatherState: [String]] = [.snow: ["snowy"],
                                                      .mainlyClear: ["sunny2"],
                                                      .clear: ["clear", "sunny1"],
                                                      .partlyCloudy: ["partlyCloudy2"],
                                                      .overcast: ["cloudy1"],
                                                      .rain: ["rainy"],
                                                      .fog: ["foggy"],
                                                      .thunderstorm: ["thunderstorm"]
    ]
    
    let weatherIcons: [WeatherState: (day: String, night: String)] = [.snow: (day: "cloud.snow.fill", night: "cloud.snow.fill"),
                                                                      .thunderstorm: (day: "cloud.bolt.rain", night: "cloud.bolt.rain"),
                                                                      .clear: (day: "sun.max.fill", night: "moon.fill"),
                                                                      .mainlyClear: (day: "cloud.sun.fill", night: "cloud.moon.fill"),
                                                                      .partlyCloudy: (day: "cloud.fill", night: "cloud.fill"),
                                                                      .overcast: (day: "cloud.fill", night: "cloud.fill"),
                                                                      .fog: (day: "cloud.fog.fill", night: "cloud.fog.fill"),
                                                                      .rain: (day: "cloud.rain.fill", night: "cloud.moon.rain.fill"),
    ]
}
