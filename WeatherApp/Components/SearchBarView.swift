//
//  SearchBarView.swift
//  WeatherApp
//
//  Created by Luka on 26.4.25..
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)
            
            TextField("Search by name or country...", text: $searchText)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(.black)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.gray.opacity(0.2))
                .shadow(color: .black.opacity(0.4), radius: 10)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
