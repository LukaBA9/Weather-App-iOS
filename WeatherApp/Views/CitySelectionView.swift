//
//  CitySelectionView.swift
//  WeatherApp
//
//  Created by Luka on 26.4.25..
//

import SwiftUI

struct CitySelectionView: View {
    @EnvironmentObject var cityInformationViewModel: CityInformationViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            SearchBarView(searchText: $cityInformationViewModel.searchText)
            Divider()
            VStack(alignment: .leading) {
                ForEach(cityInformationViewModel.filteredCities) { city in
                    CityRowView(city: city) {
                        cityInformationViewModel.updateCurrCity(city: city)
                        dismiss()
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    CitySelectionView()
}
