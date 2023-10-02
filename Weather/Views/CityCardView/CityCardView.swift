//
//  CityCardView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 10.09.2023.
//

import SwiftUI
import MapKit


struct CityCardView: View {
    @EnvironmentObject var placeVm: PlaceViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var searchable = ""
    
    var forecast: Forecast?
    var weeklyWeather: Weekly?
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.theme.yellow)
                    .ignoresSafeArea()
                    .background(.thinMaterial)
                
                VStack {
                    if !searchable.isEmpty {
                        Text(placeVm.currentCity?.country ?? "")
                        Text(placeVm.currentCity?.name ?? "")
                        let lat = placeVm.currentCity?.coordinates?.latitude
                        let lon = placeVm.currentCity?.coordinates?.longitude
                        
                        Text(String(lat ?? 0.0))
                        Text(String(lon ?? 0.0))
                        if let city = placeVm.currentCity {
                            Button {
                                placeVm.addCity(city: city)
                                try? placeVm.saveCities()
                                searchable = ""
                            } label: {
                                Text("Add city")
                            }
                        }
                        
                        Divider()
                    } else {
                        List {
                            ForEach(placeVm.cities, id: \.id) { city in
                                CityCard(forecast: placeVm.forecast, weeklyWeather: placeVm.weekly, city: city)
                                    .listRowBackground(Color.theme.yellow)
                                    .onTapGesture {
                                        placeVm.selectedIndex = city.id
                                        print("INDEX: \(city.id)")
                                        dismiss()
                                        
                                    }
                                    
                            }
                            .onDelete { indexset in
                                deleteCity(indexSet: indexset)
                            }
                        }
                        .listStyle(.plain)

//                        VStack {
//                            ScrollView {
//                                ForEach(placeVm.cities) { city in
//                                    ZStack {
//                                        CityCard(forecast: placeVm.forecast, weeklyWeather: placeVm.weekly, city: city)
//                                            .padding(.horizontal)
////                                            .contentShape(RoundedRectangle(cornerRadius: 10))
//                                            .onTapGesture {
//                                                placeVm.selectedIndex = city.id
//                                                print("INDEX: \(city.id)")
//                                                dismiss()
//
//                                            }
//
//                                        //  delete overlay
//                                        if placeVm.isEditing {
//                                            HStack {
//                                                Spacer()
//                                                Button(action: {
//                                                    // Handle delete action here
//                                                    if let index = placeVm.cities.firstIndex(where: { $0.id == city.id }) {
//                                                        placeVm.cities.remove(at: index)
//                                                    }
//                                                }) {
//                                                    Image(systemName: "trash.fill")
//                                                        .foregroundColor(.red)
//                                                        .padding(.trailing)
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                        }
                    }
                }
                .searchable(text: $searchable, placement: .navigationBarDrawer(displayMode:.always))
                
                .onChange(of: searchable) { text in
                    if !text.isEmpty {
                        placeVm.searchCities(text: text)
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button {
//                            placeVm.isEditing.toggle()
//                        } label: {
//                            if placeVm.isEditing {
//                                Text("Done")
//                                    .foregroundColor(.black)
//                                    .font(.title3)
//                                    .bold()
//                            } else {
//                                Image(systemName: "pencil")
//                                    .foregroundColor(.black)
//                                    .font(.title3)
//                                    .bold()
//                            }
//                        }
//
//                    }
                }
            }
        }
    }
    
    func deleteCity(indexSet: IndexSet) {
        placeVm.cities.remove(atOffsets: indexSet)
       try? placeVm.saveCities()
//        try? placeVm.loadCities()
        
    }
}

struct CityCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CityCardView()
                .environmentObject(DeveloperPreview.instance.vm)
                .environmentObject(LocationManager())
        }
    }
}

struct CityCard: View {
    @EnvironmentObject private var placeVM: PlaceViewModel
    @State var forecast: Forecast?
    @State var weeklyWeather: Weekly?
    
    var city: City
    
    var body: some View {
        
        if let forecast {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
//                    .stroke(lineWidth: 4)
//                    .frame(height: 150)
                    .foregroundColor(.theme.yellow)
//                    .background(Color.theme.black.opacity(0.5))
                
                
                VStack(spacing: 15){
                    HStack{
                        Text(city.name ?? "")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(Int(forecast.main.temp  - 273.15))°")
                            .font(.system(size: 40))
                            .foregroundColor(.theme.blue)
                    }
                    HStack {
                        Image(systemName: forecast.weather[0].main.weatherIcon())
                            .foregroundColor(forecast.weather[0].main.weatherIcon().switchColor())
                            .font(.largeTitle)
                    }
                    
                    
                    HStack {
                        Text(forecast.weather[0].main)
                            .foregroundColor(.white)
                        Spacer()
                        
                        
                        Group{
                            HStack {
                                Text("min:")
                                Text("\(Int(forecast.main.temp_min - 273.15))°")
                            }
                            
                            HStack {
                                Text("max:")
                                Text("\(Int(forecast.main.temp_max - 273.15))°")
                            }
                        }
                        .foregroundColor(.white)
                    }
//                    Divider()
                }
                            .padding()
            }
            .task {
                do {
                    self.forecast = try await placeVM.getWeather(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494)
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
}
