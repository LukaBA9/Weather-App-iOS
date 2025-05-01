//
//  Extensions.swift
//  WeatherApp
//
//  Created by Luka on 13.2.25..
//

import Foundation
import SwiftUI

extension Color {
    init?(hex: String) {
        let localHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var rgb: UInt64 = 0
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        guard Scanner(string: localHex).scanHexInt64(&rgb) else { return nil }
        
        red = CGFloat((rgb & 0xFF0000) >> 16) / 255
        green = CGFloat((rgb & 0x00FF00) >> 8) / 255
        blue = CGFloat(rgb & 0x0000FF) / 255
        
        self.init(red: red, green: green, blue: blue)
        
    }
}

extension Array where Element: UIColor {
    func intermediate(percentage: CGFloat) -> UIColor {
        switch percentage {
        case 0: return first ?? .clear
        case 1: return last ?? .clear
        default:
            let approxIndex = percentage / (1 / CGFloat(count - 1))
            let firstIndex = Int(approxIndex.rounded(.down))
            let secondIndex = Int(approxIndex.rounded(.up))
            let fallbackIndex = Int(approxIndex.rounded())

            let firstColor = self[firstIndex]
            let secondColor = self[secondIndex]
            let fallbackColor = self[fallbackIndex]

            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard firstColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return fallbackColor }
            guard secondColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return fallbackColor }

            let intermediatePercentage = approxIndex - CGFloat(firstIndex)
            return UIColor(red: CGFloat(r1 + (r2 - r1) * intermediatePercentage),
                           green: CGFloat(g1 + (g2 - g1) * intermediatePercentage),
                           blue: CGFloat(b1 + (b2 - b1) * intermediatePercentage),
                           alpha: CGFloat(a1 + (a2 - a1) * intermediatePercentage))
        }
    }
}

extension Color {
    func interpolate(to color: Color, fraction: CGFloat) -> Color {
        let uiColor1 = UIColor(self)
        let uiColor2 = UIColor(color)
        
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        return Color(
            red: Double(r1 + (r2 - r1) * fraction),
            green: Double(g1 + (g2 - g1) * fraction),
            blue: Double(b1 + (b2 - b1) * fraction),
            opacity: Double(a1 + (a2 - a1) * fraction)
        )
    }
}

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
                .padding(10)
            self
        }
    }
}

extension UvIndex {
    var valueDescription: String {
        let map: [Double : String] = [
            0 : "Weak",
            4 : "Moderate",
            7 : "Strong"
        ]
        
        for key in (map.keys).sorted(by: >) {
            if self >= key { return map[key]! }
        }
        
        return ""
    }
}

extension Double {
    public var formattedDescription: String {
        let rounded = self.rounded(.toNearestOrAwayFromZero)
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        guard let formatted = formatter.string(from: NSNumber(value: rounded)) else {
            return String(self)
        }
        
        return formatted
    }
}
