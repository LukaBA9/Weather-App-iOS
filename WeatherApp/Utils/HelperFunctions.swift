//
//  HelperFunctions.swift
//  WeatherApp
//
//  Created by Luka on 13.2.25..
//

import Foundation
import SwiftUI

func decToHex(value: Double) -> String {
    return String(Int(value), radix: 16)
}

func tempDegreeConverter(temp: Int8) -> Float {
    return Float (temp) + 33.8
}

func interpolatedColor(progress: CGFloat, colors: [Color]) -> Color {
        let totalColors = colors.count - 1
        let scaledProgress = progress * CGFloat(totalColors)
        let index = Int(scaledProgress)
        let remainder = scaledProgress - CGFloat(index)
        
        if index >= totalColors { return colors.last! } // Edge case
        //interpolatedColor(progress: 0.5, colors: [Color.green, .yellow, .red, .purple])
        return colors[index].interpolate(to: colors[index + 1], fraction: remainder)
    }
