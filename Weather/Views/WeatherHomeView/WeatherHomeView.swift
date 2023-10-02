//
//  MainView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 26.09.2023.
//

import SwiftUI


struct WeatherHomeView: View {
    @EnvironmentObject private var placeVM: PlaceViewModel
    @State private var searchPage = false
    @State private var forecast: Forecast?
    @State private var weeklyWeather: Weekly?

    var body: some View {
        ZStack {
            Color.theme.yellow
                .ignoresSafeArea()
            VStack {
                TabView(selection: $placeVM.selectedIndex) {
                    ForEach(placeVM.cities, id: \.id) { city in
                        MainView(
                            cityName: city.name ?? "",
                            forecast: placeVM.forecast,
                            weeklyWeather: placeVM.weekly
                        )
                        .tag(city.id)
                        .tabItem {
                            VStack {
                                Text(city.name ?? "")
                            }
                        }
                        .task {
                            do {
                                forecast = try await placeVM.getWeather(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494)
                                weeklyWeather = try await placeVM.getFiveDayForecast(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494)
                            } catch CityError.invalidData {
                                print("invalid data")
                            } catch CityError.invalidResponse {
                                print("invalid response")
                            } catch CityError.invalidURL {
                                print("invalid URL")
                            } catch {
                                print("Unexpected error")
                            }
                        }
                    }
                }
                .accentColor(.theme.blue)
            }
        }
        .fullScreenCover(isPresented: $searchPage, content: {
            CityCardView(forecast: forecast, weeklyWeather: weeklyWeather)
        })
        .toolbar {
            ToolbarItem() {
                Button {
                    self.searchPage = true
                } label: {
                    Image(systemName: "line.2.horizontal.decrease.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
        }
        .onAppear {
            try? placeVM.loadCities()
        }
    }
}


