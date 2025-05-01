//
//  MainInfoView.swift
//  WeatherApp
//
//  Created by Luka on 2.2.25..
//

import SwiftUI

struct MainInfoView: View {
    
    @EnvironmentObject var viewModel: CityInformationViewModel
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            if viewModel.readyToRender {
                ZStack {
                    BackgroundView(weatherState: viewModel.currentWeather)
                    ScrollView {
                        VStack {
                            //Main Weather Information For The Current City
                            HStack(alignment: .top) {
                                headerView
                                Spacer()
                                //Add button that stores the city
                                if !viewModel.currCityStored {
                                    storeButtonView
                                }
                            }
                            Spacer()
                            HourlyForecastView()
                            Spacer()
                            DailyForecastView()
                            infoCardsView
                        }
                        .padding(.bottom, 45)
                        .padding()
                    }
                    BottomTabView(showSlideWindow: $showSheet)
                    if showSheet {
                        Color.black.opacity(0.15)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showSheet = false
                                }
                            }
                    }
                }
                .navigationDestination(isPresented: $showSheet) {
                    CitySelectionView()
                }
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            Text(viewModel.currCity.cityName)
                .font(.system(size: 27, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(radius: 5)
            
            Image(systemName: viewModel.currWeatherImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Text("\(Double(viewModel.currentForecast.temperature2m).formattedDescription)°\(Global.shared.isFahrenheit ? "F" : "C")")
                .font(.system(size: 30, weight: .regular))
                .foregroundStyle(.white)
                .shadow(radius: 5)
        }
    }
    
    private var storeButtonView: some View {
        Button {
            //Store the city in the availableCities list
            //viewModel.saveData()
            viewModel.storedCities.append(viewModel.currCity)
            viewModel.currCityStored = true
        } label: {
            HStack {
                Image(systemName: "plus.circle")
                Text("Add")
            }
            .foregroundStyle(.white)
            .frame(width: 81, height: 35)
            .background(.black.opacity(0.27), in: RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var infoCardsView: some View {
        Grid(alignment: .leading) {
            GridRow {
                UVIndexView(shape: ClippedCircle(), header: "UV", value: Double(viewModel.hourlyForecast.uvIndex[viewModel.currHour]))
                HumidityIndexView(header: "Humidity", value: Double(viewModel.currentForecast.relativeHumidity2m))
            }
            GridRow {
                WindIndexView(header: "North", windDirection: Double(viewModel.currentForecast.windDirection10m))
                SunPhaseIndexView(header: "Sunrise", valueDescription: "Sunset", _dayDuration: viewModel.daylight)
            }
            GridRow {
                FeelsLikeIndexView(value: Double(viewModel.currentForecast.apparentTemperature), currTemp: viewModel.currTemperature)
                PressureIndexView(value: Double(viewModel.currentForecast.surfacePressure))
            }
            PrecipitationIndexView(value: Int(viewModel.currentForecast.precipitation))
        }
    }
}

#Preview {
    MainInfoView()
        .environmentObject(CityInformationViewModel())
}
