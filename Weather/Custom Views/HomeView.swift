////
////  HomeView.swift
////  Weather
////
////  Created by Alexander Zarutskiy on 28.09.2023.
////
//
//import SwiftUI
//
//struct HomeView: View {
//    @EnvironmentObject private var placeVM: PlaceViewModel
//    @State private var forecast: Forecast?
//    @State private var weeklyWeather: Weekly?
//    @State var offset: CGFloat = -5000
//    @State private var colors: [Color] = [.blue, .red]
//    var body: some View {
//        
//        GeometryReader { proxy in
//            let rect = proxy.frame(in: .global)
//            ScrollableTabBar(tabs: tabs, rect: rect , offset: $offset) {
//                HStack(spacing: 0) {
//                    ForEach(placeVM.cities, id: \.id) { city in
//                        ContentView(
//                            cityName: city.name ?? "",
//                            forecast: forecast,
//                            weeklyWeather: weeklyWeather
//                        )
////                        .aspectRatio(contentMode: .fill)
//                        .frame(maxWidth: .infinity)
//                        .cornerRadius(0)
//                        
//                        
//                        .tag(city.id)
////                        .on {
////                            placeVM.selectedIndex = city.id
////                        }
////                        .onChange(of: placeVM.selectedIndex, perform: { newValue in
////                            print("newValue: \(newValue)")
////                            if newValue == city.id {
////                                tabIsFullyVisible = true
////                            }
////                        })
//
//                        
//                        .task {
//                            
//                            print("selectionID:  \(placeVM.selectedIndex)")
//                            print("cityID:  \(city.id)")
//                            print("\(placeVM.cities.count)")
////                            if tabIsFullyVisible {
//                                do {
//                                    forecast = try await placeVM.getWeather(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494)
//                                    weeklyWeather = try await placeVM.getFiveDayForecast(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494)
//                                    //                                    tabIsFullyVisible = false
//                                } catch CityError.invalidData {
//                                    print("invalid data")
//                                } catch CityError.invalidResponse {
//                                    print("invalid response")
//                                } catch CityError.invalidURL {
//                                    print("invalid URL")
//                                } catch {
//                                    print("Unexpected error")
//                                }
////                            }
//                        }
//                    }
//                }
//            }
//        }
//        .ignoresSafeArea()
//        .onChange(of: offset) { newValue in
//            print(newValue )
//        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .environmentObject(PlaceViewModel())
//    }
//}
//
//var tabs = ["city", "city1"]
