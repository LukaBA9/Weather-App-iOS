//
//  City.swift
//  WeatherApp
//
//  Created by Luka on 2.2.25..
//

import Foundation

struct City: Identifiable, Hashable {
    var id: String
    var cityName: String
    var countryCode: String
    var timeZone: Int
    let longitude: Double
    let latitude: Double
    
    init(cityName: String, countryCode: String, timeZone: Int, longitude: Double, latitude: Double) {
        self.id = cityName
        self.cityName = cityName
        self.countryCode = countryCode
        self.timeZone = timeZone
        self.longitude = longitude
        self.latitude = latitude
    }
}
