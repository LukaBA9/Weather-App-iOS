//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Luka on 28.4.25..
//

import Foundation

struct ForecastModel: Codable {
    let current: Current
    let hourly: Hourly
    let daily: Daily
    
    init(current: Current, hourly: Hourly, daily: Daily) {
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
    
    init() {
        self.current = Current()
        self.daily = Daily()
        self.hourly = Hourly()
    }

    struct Current: Codable {
        let time: Date
        let temperature2m: Float
        let weatherCode: Float
        let precipitation: Float
        let surfacePressure: Float
        let relativeHumidity2m: Float
        let apparentTemperature: Float
        let isDay: Float
        let windSpeed10m: Float
        let windDirection10m: Float
        
        init(time: Date, temperature2m: Float, weatherCode: Float, precipitation: Float, surfacePressure: Float, relativeHumidity2m: Float, apparentTemperature: Float, isDay: Float, windSpeed10m: Float, windDirection10m: Float) {
            self.time = time
            self.temperature2m = temperature2m
            self.weatherCode = weatherCode
            self.precipitation = precipitation
            self.surfacePressure = surfacePressure
            self.relativeHumidity2m = relativeHumidity2m
            self.apparentTemperature = apparentTemperature
            self.isDay = isDay
            self.windSpeed10m = windSpeed10m
            self.windDirection10m = windDirection10m
        }
        
        init() {
            time = Date()
            temperature2m = 0
            weatherCode = 0
            precipitation = 0
            surfacePressure = 0
            relativeHumidity2m = 0
            apparentTemperature = 0
            isDay = 0
            windSpeed10m = 0
            windDirection10m = 0
        }
    }
    struct Hourly: Codable {
        let time: [Date]
        let temperature2m: [Float]
        let relativeHumidity2m: [Float]
        let apparentTemperature: [Float]
        let precipitation: [Float]
        let weatherCode: [Float]
        let windSpeed10m: [Float]
        let windDirection10m: [Float]
        let uvIndex: [Float]
        let isDay: [Float]
        let surfacePressure: [Float]
        
        init(time: [Date], temperature2m: [Float], relativeHumidity2m: [Float], apparentTemperature: [Float], precipitation: [Float], weatherCode: [Float], windSpeed10m: [Float], windDirection10m: [Float], uvIndex: [Float], isDay: [Float], surfacePressure: [Float]) {
            self.time = time
            self.temperature2m = temperature2m
            self.weatherCode = weatherCode
            self.precipitation = precipitation
            self.surfacePressure = surfacePressure
            self.relativeHumidity2m = relativeHumidity2m
            self.apparentTemperature = apparentTemperature
            self.isDay = isDay
            self.windSpeed10m = windSpeed10m
            self.windDirection10m = windDirection10m
            self.uvIndex = uvIndex
        }
        
        init() {
            time = [Date()]
            temperature2m = [0]
            weatherCode = [0]
            precipitation = [0]
            surfacePressure = [0]
            relativeHumidity2m = [0]
            apparentTemperature = [0]
            isDay = [0]
            windSpeed10m = [0]
            windDirection10m = [0]
            uvIndex = [0]
        }
    }
    struct Daily: Codable {
        let time: [Date]
        let weatherCode: [Float]
        let sunset: [Int64]
        let sunrise: [Int64]
        let temperature2mMax: [Float]
        let temperature2mMin: [Float]
        let windSpeed10mMax: [Float]
        let precipitationSum: [Float]
        let uvIndexMax: [Float]
        
        init(time: [Date], weatherCode: [Float], sunset: [Int64], sunrise: [Int64], temperature2mMax: [Float], temperature2mMin: [Float], windSpeed10mMax: [Float], precipitationSum: [Float], uvIndexMax: [Float]) {
            self.time = time
            self.temperature2mMin = temperature2mMin
            self.temperature2mMax = temperature2mMax
            self.sunset = sunset
            self.sunrise = sunrise
            self.weatherCode = weatherCode
            self.windSpeed10mMax = windSpeed10mMax
            self.precipitationSum = precipitationSum
            self.uvIndexMax = uvIndexMax
        }
        
        init() {
            self.time = [Date()]
            self.temperature2mMin = [0]
            self.temperature2mMax = [0]
            self.sunset = [0]
            self.sunrise = [0]
            self.weatherCode = [0]
            self.windSpeed10mMax = [0]
            self.precipitationSum = [0]
            self.uvIndexMax = [0]
        }
    }
}
