//
//  BottomTabView.swift
//  WeatherApp
//
//  Created by Luka on 22.2.25..
//

import SwiftUI

struct BottomTabView: View {
    @Binding var showSlideWindow: Bool
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                TransparentBlurView(removeAllFilters: false)
                    .frame(height: 80)
                HStack(alignment: .bottom) {
                    Spacer()
                    //When clicked shows the panel that contains city selection
                    Button {
                        withAnimation {
                            showSlideWindow.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 27))
                    }

                }
                .padding(.horizontal, 40)
            }
        }
        .ignoresSafeArea()
    }
}


