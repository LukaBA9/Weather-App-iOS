//
//  DeveloperPreview.swift
//  WeatherApp
//
//  Created by Luka on 25.4.25..
//

import Foundation

enum CityName: String {
    case losAngeles = "Los Angeles"
    case newYork = "New York"
    case london = "London"
    
    var cityName: String { self.rawValue }
}

class DeveloperPreview {
    static let shared: DeveloperPreview = DeveloperPreview()
    
    var cities: [City] = [CityFactory.shared.losAngeles, CityFactory.shared.newYork, CityFactory.shared.london]
}
