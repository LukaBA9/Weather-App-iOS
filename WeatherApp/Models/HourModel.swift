//
//  HourModel.swift
//  WeatherApp
//
//  Created by Luka on 18.2.25..
//

import Foundation


struct HourModel {
    let hour: Int
    let minute: Int
    
    static func currTime() -> HourModel {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: Date())
        return HourModel(hour: components.hour ?? 0, minute: components.minute ?? 0)
    }
    
    static func subtract(time1: HourModel, time2: HourModel) -> HourModel {
        var resultingMinutes = time2.minute - time1.minute
        var hourCarrier = 0
        if resultingMinutes < 0 {
            resultingMinutes = 60 + resultingMinutes
            hourCarrier = 1
        }
        let resultingHours = time2.hour - time1.hour - hourCarrier
        return HourModel(hour: resultingHours, minute: resultingMinutes)
    }
    
    static func convertToMinutes(_ hour: Int, _ minute: Int) -> Double {
        return Double(hour * 60 + minute)
    }
}
