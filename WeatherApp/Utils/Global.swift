//
//  GlobalSettings.swift
//  WeatherApp
//
//  Created by Luka on 25.2.25..
//

import Foundation

class Global {
    static let shared = Global()
    var isFahrenheit: Bool = false
    var timeZone: TimeZone = .current
    var currentDay: Int {
        Calendar.current.component(.weekday, from: Date())
    }
//    var currentHour: Int {
//        Calendar.current.component(.hour, from: Date()) - 1 + (TimeZone.current.secondsFromGMT(for: Date()) / 3600)
//    }
    
    private init() {}
    
    func currentHour(timeZone: Int) -> Int {
        
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents(in: TimeZone(abbreviation: "GMT")!, from: now)
        guard let hour = components.hour else { return 0 }
        if hour + timeZone < 0 {
            return 24 + (hour + timeZone)
        }
        return hour + timeZone
    }
}
