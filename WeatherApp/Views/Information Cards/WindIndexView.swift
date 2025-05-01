//
//  WindIndexView.swift
//  WeatherApp
//
//  Created by Luka on 16.2.25..
//

import SwiftUI
import Foundation
import Combine
import CoreLocation

struct WindIndexView: View {
    let header: String
    
    let windDirection: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text("\(windDirection.formattedDescription)°")
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            HStack {
                Spacer()
                CompassView(directionAngle: windDirection)
            }
        }
        .padding()
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }
}

struct CompassView: View {
    let directionAngle: Double
    var body: some View {
        ZStack {
            ForEach(Marker.markers(), id: \.degrees) { marker in
                CompassMarkerView(marker: marker, compassDegress: 0)
            }
            Capsule()
                .frame(width: 4,
                        height: 10)
                .foregroundColor(.blue)
                .offset(y: -41)
                .rotationEffect(Angle(degrees: directionAngle))
            
        }
        .frame(width: 100, height: 100)
        .rotationEffect(Angle(degrees: 0))
        .statusBarHidden(true)
    }
}

struct Marker: Hashable {
    let degrees: Double
    let label: String
    
    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }
    
    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "S"),
            Marker(degrees: 90, label: "W"),
            Marker(degrees: 180, label: "N"),
            Marker(degrees: 270, label: "E")
        ]
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double

    var body: some View {
        VStack {
            Capsule()
                .frame(width: 3,
                       height: 10)
                .foregroundColor(.white)
                //.padding(.bottom, 30)
                .offset(y: -14.6)

            Text(marker.label)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                    .rotationEffect(Angle(degrees: -self.marker.degrees))
                    .padding(.top, 27)
        }.rotationEffect(Angle(degrees: marker.degrees))
    }
}
#Preview {
    WindIndexView(header: "", windDirection: 0)
}
