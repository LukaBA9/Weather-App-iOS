//
//  CityTemperaturesViewModel.swift
//  WeatherApp
//
//  Created by Luka on 24.2.25..
//

import Foundation
import Combine
import OpenMeteoSdk
import CoreData

class CityInformationViewModel : ObservableObject {
    
    @Published var readyToRender: Bool = false

    @Published var storedCities: [City] = [CityFactory.shared.losAngeles]
    
    @Published var currCity: City = DeveloperPreview.shared.cities.first!
    
    @Published var currCityStored: Bool = true
    
    @Published var searchText: String = ""
    @Published var filteredCities: [City] = []
    
    @Published var currentForecast: ForecastModel.Current = .init()
    @Published var hourlyForecast: ForecastModel.Hourly = .init()
    @Published var dailyForecast: ForecastModel.Daily = .init()
    
    @Published var utcOffset: Int32 = 0
    
    @Published var temperateRange: (min: Double, max: Double) = (1000, -1000)
    
    private let downloadManager: DownloadManager = DownloadManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    public var currentWeather: WeatherState {
        return weatherCodes[Int(currentForecast.weatherCode)] ?? .clear
    }
    
    public var daylight: (sunrise: Double, sunset: Double) {
        return (sunrise: Double(self.dailyForecast.sunrise[0]), sunset: Double(self.dailyForecast.sunset[0]))
    }
    
    public var dayDuration: Double {
        return Double(dailyForecast.sunset[0] - dailyForecast.sunrise[0])
    }
    
    public var currWeatherImage: String {
        if isDay {
            return WeatherComponents.shared.weatherIcons[self.currentWeather]?.day ?? "sun.fill"
        } else {
            return WeatherComponents.shared.weatherIcons[self.currentWeather]?.night ?? "sun.fill"
        }
    }
    
    public var currTemperature: Double {
        return Double(currentForecast.temperature2m)
    }
    
    public var currHour: Int {
        return Global.shared.currentHour(timeZone: Int(self.utcOffset))
    }
    
    private var isDay: Bool {
        return self.currentForecast.isDay == 1
    }
    
    init() {
        self.addSubscribers()
        self.updateCurrCity(city: DeveloperPreview.shared.cities.first!)
    }
    
    func currWeatherIcon(cityId: String) -> String {
            
        let weatherCondition: WeatherState = weatherCodes[Int(self.currentForecast.weatherCode)]!
        let icons = WeatherComponents.shared.weatherIcons[weatherCondition]!
            
        return isDay ? icons.day : icons.night
            
    }
    
    func updateCurrCity(city: City) {
        Task {
            do {
                try await downloadManager.fetchWeatherData(latitude: city.latitude, longitude: city.longitude) { [weak self] utcOffset, currentForecast, dailyForecast, hourlyForecast in
                    self?.utcOffset = utcOffset
                    self?.currentForecast = currentForecast
                    self?.dailyForecast = dailyForecast
                    self?.hourlyForecast = hourlyForecast
                }
                await MainActor.run {
                    currCityStored = self.storedCities.contains(city)
                    currCity = city
                    updateTemperatureRange()
                    readyToRender = true
                }
            } catch {
                return
            }
        }
    }
    
    func updateTemperatureRange() {
        self.temperateRange = (1000, -1000)
        for i in 0..<7 {
            let curr = Double(self.dailyForecast.temperature2mMin[i].rounded(.toNearestOrAwayFromZero))
            self.temperateRange.min = min(self.temperateRange.min, curr)
        }
        for i in 0..<7 {
            let curr = Double(self.dailyForecast.temperature2mMax[i].rounded(.toNearestOrAwayFromZero))
            self.temperateRange.max = max(self.temperateRange.max, curr)
        }
    }
    
    func isDay(offset: Double) -> Bool {
        let currTime = abs(Date().timeIntervalSince1970) + (offset * 3600)
        let startOfDay = Calendar.current.startOfDay(for: self.hourlyForecast.time[0])
        let timestamp = startOfDay.timeIntervalSince1970
        
        let index = Int((currTime - timestamp) / 86_400)
        return currTime >= Double(self.dailyForecast.sunrise[index]) && currTime <= Double(self.dailyForecast.sunset[index])
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(self.$storedCities)
            .map { (text, defaultCities) -> [City] in
                guard !text.isEmpty else {
                    return defaultCities
                }
                return DeveloperPreview.shared.cities.filter { $0.cityName.lowercased().contains(text.lowercased()) || (($0.countryCode.lowercased().contains(text.lowercased()))) }
            }
            .sink { [weak self] filteredCities in
                guard let self = self else { return }
                self.filteredCities = filteredCities
            }
            .store(in: &cancellables)
    }
}
