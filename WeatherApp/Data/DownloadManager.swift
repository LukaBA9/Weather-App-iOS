//
//  DownloadManager.swift
//  WeatherApp
//
//  Created by Luka on 29.4.25..
//

import Foundation
import Combine
import OpenMeteoSdk

class DownloadManager {
    
    @Published var data: ForecastModel? = nil
    var dataSubscription: AnyCancellable?
    
//    func fetchWeatherData() {
//        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=34.0522&longitude=-118.2437&daily=weather_code,sunset,sunrise,temperature_2m_max,temperature_2m_min,wind_speed_10m_max,precipitation_sum,uv_index_max&hourly=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,wind_direction_10m,uv_index,is_day,surface_pressure&current=temperature_2m,weather_code,precipitation,surface_pressure,relative_humidity_2m,apparent_temperature,is_day,wind_speed_10m,wind_direction_10m&timezone=auto&format=flatbuffers") else { return }
//        
//        dataSubscription = URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))
//            .tryMap { (output) -> Foundation.Data in
//                guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
//            .receive(on: DispatchQueue.main)
//            .decode(type: ForecastModel.self, decoder: (JSONDecoder()))
//            .sink { (completion) in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            } receiveValue: { [weak self] returnedData in
//                self?.data = returnedData
//                self?.dataSubscription?.cancel()
//            }
//    }
    
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (_ utcOffset: Int32, _ currentForecast: ForecastModel.Current, _ dailyForecast: ForecastModel.Daily, _ hourlyForecast: ForecastModel.Hourly) -> Void) async throws {
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=weather_code,sunset,sunrise,temperature_2m_max,temperature_2m_min,wind_speed_10m_max,precipitation_sum,uv_index_max&hourly=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,wind_direction_10m,uv_index,is_day,surface_pressure&current=temperature_2m,weather_code,precipitation,surface_pressure,relative_humidity_2m,apparent_temperature,is_day,wind_speed_10m,wind_direction_10m&timezone=auto&format=flatbuffers")!
        
        let responses = try await WeatherApiResponse.fetch(url: url)

        /// Process first location. Add a for-loop for multiple locations or weather models
        let response = responses[0]

        /// Attributes for timezone and location
        let utcOffsetSeconds = response.utcOffsetSeconds
        let utcOffsetHours = utcOffsetSeconds / 3600

        let current = response.current!
        let hourly = response.hourly!
        let daily = response.daily!
        
        /// Note: The order of weather variables in the URL query and the `at` indices below need to match!
        let data = ForecastModel(
            current: .init(
                time: Date(timeIntervalSince1970: TimeInterval(current.time + Int64(utcOffsetSeconds))),
                temperature2m: (current.variables(at: 0)!.value),
                weatherCode: (current.variables(at: 1)!.value),
                precipitation: (current.variables(at: 2)!.value),
                surfacePressure: (current.variables(at: 3)!.value),
                relativeHumidity2m: (current.variables(at: 4)!.value),
                apparentTemperature: (current.variables(at: 5)!.value),
                isDay: (current.variables(at: 6)!.value),
                windSpeed10m: (current.variables(at: 7)!.value),
                windDirection10m: (current.variables(at: 8)!.value)
            ),
            hourly: .init(
                time: hourly.getDateTime(offset: utcOffsetSeconds),
                temperature2m: (hourly.variables(at: 0)!.values),
                relativeHumidity2m: (hourly.variables(at: 1)!.values),
                apparentTemperature: (hourly.variables(at: 2)!.values),
                precipitation: (hourly.variables(at: 3)!.values),
                weatherCode: (hourly.variables(at: 4)!.values),
                windSpeed10m: (hourly.variables(at: 5)!.values),
                windDirection10m: (hourly.variables(at: 6)!.values),
                uvIndex: (hourly.variables(at: 7)!.values),
                isDay: (hourly.variables(at: 8)!.values),
                surfacePressure: (hourly.variables(at: 9)!.values)
            ),
            daily: .init(
                time: daily.getDateTime(offset: utcOffsetSeconds),
                weatherCode: (daily.variables(at: 0)!.values),
                sunset: (daily.variables(at: 1)!.valuesInt64),
                sunrise: (daily.variables(at: 2)!.valuesInt64),
                temperature2mMax: (daily.variables(at: 3)!.values),
                temperature2mMin: (daily.variables(at: 4)!.values),
                windSpeed10mMax: (daily.variables(at: 5)!.values),
                precipitationSum: (daily.variables(at: 6)!.values),
                uvIndexMax: (daily.variables(at: 7)!.values)
            )
        )
        
        await MainActor.run {
            completion(utcOffsetHours, data.current, data.daily, data.hourly)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .gmt
        dateFormatter.dateFormat = "HH:mm"
    }
}
