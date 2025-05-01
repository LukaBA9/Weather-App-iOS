//
//  PressureIndexView.swift
//  WeatherApp
//
//  Created by Luka on 20.2.25..
//

import SwiftUI

struct PressureIndexView: View {
    private let header = "Pressure"
    let value: Double
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text(Int(value).description)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            HStack {
                Spacer()
                ZStack {
                    ClippedCircle()
                        .stroke(
                            .gray.opacity(0.33),
                        style: StrokeStyle(lineWidth: 10, lineCap:.round)
                    )
                    .frame(width: 100, height: 100)
                    ClippedCircle()
                        .trim(from: 1 - (value / 1850), to: 1)
                        .stroke(
                            Color("customWhite"),
                        style: StrokeStyle(lineWidth: 10, lineCap:.round)
                    )
                    .frame(width: 100, height: 100)
                    VStack {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 27, weight: .bold))
                            .foregroundStyle(Color("customWhite"))
                            .offset(y: 8)
                        Text("mbar")
                            .foregroundStyle(.white)
                            .offset(y: 24)
                    }
                }
            }
        }
        .padding()
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }
}

#Preview {
    PressureIndexView(value: 1)
}
