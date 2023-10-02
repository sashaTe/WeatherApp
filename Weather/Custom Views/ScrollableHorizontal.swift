////
////  ScrollableHorizontal.swift
////  Weather
////
////  Created by Alexander Zarutskiy on 28.09.2023.
////
//
//import SwiftUI
//
//struct ScrollableHorizontal: View {
//    @EnvironmentObject private var placeVM: PlaceViewModel
//    @State private var forecast: Forecast?
//    @State private var weeklyWeather: Weekly?
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(placeVM.cities, id: \.id) { city in
//                        ContentView(
//                            cityName: city.name ?? "",
//                            forecast: forecast,
//                            weeklyWeather: weeklyWeather
//                        )
//                        .tag(city.id)
//                        .frame(width: geometry.size.width, height: geometry.size.height)
//                        .task {
//                            
//                            print("selectionID:  \(placeVM.selectedIndex)")
//                            print("cityID:  \(city.id)")
//                            print("\(placeVM.cities.count)")
//                            //                            if tabIsFullyVisible {
//                            do {
//                                forecast = try await placeVM.getWeather(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494)
//                                weeklyWeather = try await placeVM.getFiveDayForecast(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494)
//                                //                                    tabIsFullyVisible = false
//                            } catch CityError.invalidData {
//                                print("invalid data")
//                            } catch CityError.invalidResponse {
//                                print("invalid response")
//                            } catch CityError.invalidURL {
//                                print("invalid URL")
//                            } catch {
//                                print("Unexpected error")
//                            }
//                            //                            }
//                        }
//                    }
//                    
//                }
//            }
//            .ignoresSafeArea()
//        }
//        }
//        
//    }
////    .fullScreenCover(isPresented: $searchPage, content: {
////        CityCardView(forecast:forecast, weeklyWeather: weeklyWeather)
////    })
////    .toolbar {
////        ToolbarItem() {
////            Button {
////                self.searchPage = true
////            } label: {
////                Image(systemName: "line.2.horizontal.decrease.circle.fill")
////                    .font(.title)
////                    .foregroundColor(.black)
////            }
////        }
////    }
////    .tabViewStyle(.page(indexDisplayMode: .always))
////    .onAppear {
////        try? placeVM.loadCities()
////    }
//        
//
//
//struct ScrollableHorizontal_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollableHorizontal()
//    }
//}
