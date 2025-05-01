//
//  UVIndexView.swift
//  WeatherApp
//
//  Created by Luka on 14.2.25..
//

import SwiftUI

struct UVIndexView<S: Shape>: View {
    let shape: S
    let header: String
    let value: UvIndex

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text(value.valueDescription)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            HStack {
                Spacer()
                ZStack {
                    shape
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.green, .yellow, .red, .purple]),
                            center: .center,
                            startAngle: .degrees(-225),
                            endAngle: .degrees(45)
                        ),
                        style: StrokeStyle(lineWidth: 10, lineCap:.round)
                    )
                    .frame(width: 100, height: 100)
                    GeometryReader { geometry in
                        let size = min(geometry.size.width, geometry.size.height)
                        let radius = size / 2
                        let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                    
                        let startAngle = -225.0
                        let endAngle = 45.0
                                    
                        let angle = startAngle + (endAngle - startAngle) * value / 10
                                    
                        let x = center.x + radius * cos(angle * .pi / 180)
                        let y = center.y + radius * sin(angle * .pi / 180)
                                    
                        Circle()
                        .fill(.white)
                            .frame(width: 10, height: 10)
                            .position(x: x, y: y)
                        }
                        .frame(width: 100, height: 100)
                    Text(Int(value).description)
                        .foregroundStyle(.white)
                        .font(.system(size: 27, weight: .bold))
                }
            }
        }
        .padding()
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }
}
