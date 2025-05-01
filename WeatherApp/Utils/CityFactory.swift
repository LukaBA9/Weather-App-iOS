//
//  CityFactory.swift
//  WeatherApp
//
//  Created by Luka on 25.4.25..
//

import Foundation

class CityFactory {
    static var shared: CityFactory = CityFactory()
    
//    var losAngelesEntity: City {
//        let city = City()
//        city.cityName = "Los Angeles"
//        city.countryCode = "California"
//        city.id = "Los Angeles"
//        city.latitude = 34.05
//        city.longitude = -118.24
//        city.timeZone = -7
//        return city
//    }
//    
//    var londonEntity: City {
//        let city = City()
//        city.cityName = "London"
//        city.countryCode = "United Kingdom"
//        city.id = "London"
//        city.latitude = 51.509865
//        city.longitude = -0.118092
//        city.timeZone = 0
//        return city
//    }
//    
//    var newYorkEntity: City {
//        let city = City()
//        city.cityName = "New York"
//        city.countryCode = "New York"
//        city.id = "New York"
//        city.latitude = 40.730610
//        city.longitude = -73.935242
//        city.timeZone = -4
//        return city
//    }
    
    var losAngeles: City {
        return City(cityName: "Los Angeles", countryCode: "California", timeZone: -7, longitude: -118.24, latitude: 34.05)
    }
    
    var london: City {
        return City(cityName: "London", countryCode: "United Kingdom", timeZone: 0, longitude: -0.118092, latitude: 51.509865)
    }
    
    var newYork: City {
        return City(cityName: "New York", countryCode: "New York", timeZone: -4, longitude: -73.935242, latitude: 40.730610)
    }
}
