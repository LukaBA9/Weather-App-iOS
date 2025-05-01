//
//  HumidityIndexView.swift
//  WeatherApp
//
//  Created by Luka on 14.2.25..
//

import SwiftUI

struct HumidityIndexView: View {
    let header: String
    let value: Double
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text("\(value.formatted())%")
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
                        .trim(from: 1 - (value / 100), to: 1)
                        .stroke(
                        Color("customWhite"),
                        style: StrokeStyle(lineWidth: 10, lineCap:.round)
                    )
                    .frame(width: 100, height: 100)
                    Image(systemName: "drop.fill")
                        .foregroundStyle(Color("customWhite"))
                }
            }
        }
        .padding()
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }

}

#Preview {
    HumidityIndexView(header: "Humidity", value: 42)
}
