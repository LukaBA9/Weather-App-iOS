//
//  LunarPhaseIndexView.swift
//  WeatherApp
//
//  Created by Luka on 20.2.25..
//

import SwiftUI
import AVKit

struct LunarPhaseIndexView: View {
    let header: String
    let valueDescription: String
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(header)
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 17, weight: .medium))
                Text(valueDescription)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .bold))
            }
            Spacer()
            HStack {
                Spacer()
            }
        }
        .aspectRatio(0.941, contentMode: .fill)
        .padding()
        .background(.blue.opacity(0.3), in: RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 12)
    }
    
    func currPhase() -> Int {
        return 1
    }
}

#Preview {
    LunarPhaseIndexView(header: "", valueDescription: "")
}
