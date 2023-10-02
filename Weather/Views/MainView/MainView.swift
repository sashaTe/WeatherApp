//
//  ContentView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 21.07.2023.
//

import SwiftUI
import MapKit

struct MainView: View {
    @EnvironmentObject private var placeVM: PlaceViewModel
    
    var cityName: String
    var forecast: Forecast?
    var weeklyWeather: Weekly?

    init(cityName: String, forecast: Forecast?, weeklyWeather: Weekly?) {
        self.cityName = cityName
        self.forecast = forecast
        self.weeklyWeather = weeklyWeather
    }

    var body: some View {
        ZStack {
            Color.theme.yellow
                .ignoresSafeArea()

            VStack(spacing: 0) {
                CityNameView(city: cityName, forecast: forecast)

                DateView(vm: placeVM)

                TypeOfWeather(forecast: forecast)

                MainTemperatureView(forecast: forecast)

                DailySummary(forecast: forecast)
                
                if let forecast = forecast {
                    WeatherParametersView(windSpeed: forecast.wind?.speed ?? 0, humidityPercentage: forecast.main.humidity , visibilityRange: forecast.visibility)
                        .padding(.horizontal)
                        .padding(.vertical)
                        .frame(height: 150)
                }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(placeVM.weeklyForecast, id: \.self) { day in
                                let weatherMain = day.weather[0].main
                                let weatherIcon = weatherMain.weatherIcon()
                                ForecastCardView(temperature: day.main.temp_max, date: day.dt_txt, image: weatherIcon, name: placeVM.weekly?.city.name ?? "hz")
                                    .frame(width: 80)
                                    .frame(minHeight: 120, maxHeight: 140)
                                    .padding(.bottom)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    }
                
            }
            .statusBarHidden()
            .navigationBarBackButtonHidden()
        }
    }
}












































//struct ContentView: View {
//    @EnvironmentObject private var vm: ViewModel
//    @EnvironmentObject private var placeVM: PlaceViewModel
//    @EnvironmentObject private var locationManager: LocationManager
//    @State private var city: CityElement?
////    @State var cityName: String?
//    @State var forecast: Forecast?
//    @State var weeklyWeather: Weekly?
////    @State private var citySearch: String = ""
//    @State private var isPresented: Bool = false
//
//    @State private var opacity = true
//    @State private var lat: Double
//    @State private var lon: Double
//    @State var returnedPlace = Place(mapItem: MKMapItem())
//    var cityName: String
//
////    init() {
////        self.lat = locationManager.userLocation?.coordinate.latitude
////        self.lon = locationManager.userLocation?.coordinate.longitude
////    }
//
////    init(cityName: String) {
////        self.cityName = cityName
////    }
//
//    init(lat: Double, lon: Double, cityName: String) {
//        self.lat = lat
//        self.lon = lon
//        self.cityName = cityName
//    }
//
//    var body: some View {
//
//            ZStack() {
//                Color.theme.yellow
//                    .ignoresSafeArea()
//
//                VStack(spacing: 0) {
//                    CityNameView(city: cityName, forecast: forecast)
//
//                    DateView(vm: vm)
//
//                    TypeOfWeather(forecast: forecast)
//
//                    MainTemperatureView(forecast: forecast)
//
//                    DailySummary(forecast: forecast)
//                    if let forecast {
//                         WeatherParametersView(speedOfWind: forecast.wind?.speed ?? 0, humidityPercent: forecast.main.humidity , visibilityRange: forecast.visibility)
//
//                        .padding(.horizontal)
//                        .padding(.vertical)
//                        .frame(height: 150)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 30) {
//                            ForEach(placeVM.weeklyForecast, id: \.self) { day in
//                                let weatherMain = day.weather[0].main
//                                let weatherIcon = weatherMain.weatherIcon()
//                                ForecastCardView(temperature: day.main.temp_max, date: day.dt_txt, image: weatherIcon, name: placeVM.weekly?.city.name ?? "hz")
//                                    .frame(width: 80)
//                                    .frame(maxHeight: 140)
//                                    .padding(.bottom)
//
//                            }
//                        }
//
//                        .padding(.horizontal)
//                        .padding(.vertical, 10)
//                    }
//
//                }
////                    Spacer()
//                }
//
////            }
////
////            .sheet(isPresented: $isPresented, content: {
////                withAnimation(.easeInOut) {
////                    SearchView()
////                }
////            })
////            .toolbar(content: {
////                ToolbarItem(placement: .navigationBarLeading) {
////                   CircleButtonView(iconName: "plus")
////                        .onTapGesture {
////                            isPresented.toggle()
////                        }
////
////                }
////            })
//                .statusBarHidden()
//                .navigationBarBackButtonHidden()
////                .fullScreenCover(isPresented: $searchPage) {
////                    CityCardView(returnedPlace: $returnedPlace)
////                }
////                NavigationLink("", destination: CityCardView(), isActive: $searchPage)
//                .task {
//                do {
////                    _ = try await vm.appendCurrentCity()
////                    let cityArray = try await vm.getCity(name: vm.appendCurrentCity())
////                    city = cityArray.first
////                    lat = vm.lat ?? locationManager.userLocation?.coordinate.latitude
////                    lon = vm.lon ?? locationManager.userLocation?.coordinate.longitude
//                    forecast = try await placeVM.getWeather(lat: lat , lon: lon )
//                    weeklyWeather = try await placeVM.getFiveDayForecast(lat: lat , lon: lon )
//
//                } catch  CityError.invalidData {
//                    print("invalid data")
//                } catch CityError.invalidResponse {
//                    print("invalid response")
//                } catch CityError.invalidURL {
//                    print("invalid URL")
//                } catch {
//                    print("Unexpected error")
//                }
//
//
//        }
//        }

//    }
//
//}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ContentView(lat: 55.750446, lon: 37.617494, cityName: "London")
//
//                .environmentObject(dev.vm)
//                .environmentObject(LocationManager())
//                .environmentObject(PlaceViewModel())
//        }
//
//
//    }
//}
    

    
    
    


//struct WeeklyForecast: View {
//    @EnvironmentObject private var vm: ViewModel
//    var body: some View {
//
//    }
//}

