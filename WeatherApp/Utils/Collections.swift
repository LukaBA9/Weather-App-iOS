//
//  Collections.swift
//  WeatherApp
//
//  Created by Luka on 3.2.25..
//

import Foundation

enum DayDescription: String, CaseIterable {
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
    case sunday = "Sun"
}

var daysOfTheWeek: [DayDescription] = [
    .sunday,
    .monday,
    .tuesday,
    .wednesday,
    .thursday,
    .friday,
    .saturday
]
