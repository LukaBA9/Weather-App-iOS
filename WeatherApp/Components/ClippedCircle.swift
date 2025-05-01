//
//  ClippedCircle.swift
//  WeatherApp
//
//  Created by Luka on 14.2.25..
//

import SwiftUI

struct ClippedCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startAngle: Angle = .degrees(45)
        let endAngle: Angle = .degrees(135)
        
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        return path
    }
    
    
}

#Preview {
    
    ClippedCircle()
        .stroke(
            AngularGradient(
                gradient: Gradient(colors: [.green, .yellow, .red, .purple]),
                center: .center,
                startAngle: .degrees(-225),
                endAngle: .degrees(45)
            ),
            style: StrokeStyle(lineWidth: 10, lineCap: .round)
        )
        .frame(width: 100, height: 100)
}
