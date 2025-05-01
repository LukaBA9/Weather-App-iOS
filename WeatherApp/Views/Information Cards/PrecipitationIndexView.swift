//
//  PrecipitationIndexView.swift
//  WeatherApp
//
//  Created by Luka on 20.2.25..
//

import SwiftUI

struct PrecipitationIndexView: View {
    private let header: String = "Precipitation"
    var value: Int
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text("Today")
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            Spacer()
            HStack {
                Spacer()
                Text("\(value) mm")
                    .foregroundStyle(.white)
                    .font(.system(size: 36, weight: .semibold))
            }
        }
        //.aspectRatio(0.941, contentMode: .fill)
        .padding()
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }
}

#Preview {
    PrecipitationIndexView(value: 0)
}
