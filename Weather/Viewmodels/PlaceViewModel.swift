//
//  PlaceViewModel.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 26.09.2023.
//

import Foundation
import MapKit


@MainActor
class PlaceViewModel: ObservableObject {
    
    @Published var forecast: Forecast?
    @Published var weeklyForecast = [WeatherInfo]()
    @Published var now = Date()

            @Published var places: [Place] = []
            @Published var currentCity: City?
            @Published var cities: [City] = []
            @Published var weekly: Weekly?
            @Published var selectedIndex: String = ""
            @Published var isEditing: Bool = false
        
            init() {
                try? loadCities()
            }
    
    func addUserCurrentGeo() {
        LocationManager.shared.userLocation?.coordinate.latitude
        LocationManager.shared.userLocation?.coordinate.longitude
        
    }
            func searchCities(text: String) {
                guard !text.isEmpty else {
                    self.currentCity = nil
                    return
                }
                let geoCoder = CLGeocoder()
                let location = text
                geoCoder.geocodeAddressString(location) { placemark, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                    }
                    if placemark != nil {
                        self.currentCity = nil
                        self.currentCity = City(placemark: placemark![0])
        
                    } else {
                        self.currentCity = nil
                    }
                }
            }
        
            func loadCities() throws {
                if let data = UserDefaults.standard.data(forKey: "cities"){
                    let decoder = JSONDecoder()
                    self.cities = try decoder.decode([City].self, from: data)
                    print("loaded")
                    print(self.cities)
                }
            }
        
            func saveCities() throws {
                let encoder = JSONEncoder()
                let data = try encoder.encode(self.cities.isEmpty ? [City]() : self.cities)
                UserDefaults.standard.set(data, forKey: "cities")
                print(self.cities.isEmpty ? "deleted" : "saved")
            }
        
            func addCity(city:City){
                if !cities.contains(where: { $0.name == city.id}) {
                    cities.append(city)
                    do {
                        try saveCities()
                        try loadCities()
                    } catch {print("ERROR LOAD SAVE")}
                } else {
                    print("City already exist")
                }
            }
        
            func getWeather(lat: Double, lon: Double) async throws -> Forecast {
        
                let endpoint = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=3e01a065727a146c0c658097d813e039"
        
        
                guard let url = URL(string: endpoint) else {throw CityError.invalidURL}
        
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let response = response as?HTTPURLResponse, response.statusCode == 200 else { print("bad getweather response")
                    throw CityError.invalidResponse}
        
                do {
                    let decoder = JSONDecoder()
                    let forecast = try decoder.decode(Forecast.self, from: data)
                    self.forecast = forecast
                    return forecast
                } catch {
                    print("Decoding Error:", error)
                    throw CityError.invalidData
                }
            }
        
            func getFiveDayForecast(lat: Double, lon: Double) async throws -> Weekly {
                let endpoint = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=3e01a065727a146c0c658097d813e039"
                print(endpoint)
        
                guard let url = URL(string: endpoint) else {throw CityError.invalidURL}
        
                let (data, response) = try await URLSession.shared.data(from: url)
        
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {throw CityError.invalidResponse}
        
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Weekly.self, from: data)
                    let array = filterArray(array: result.list)
                    DispatchQueue.main.async {
                        self.weeklyForecast = array
                        self.weekly = result
                        }
                    return result
                } catch  {
                    print(error.localizedDescription)
                    throw CityError.invalidData
                }
            }
        
            func filterArray(array: [WeatherInfo]) -> [WeatherInfo] {
                let startIndex = 5
                let step = 8
        
                let filteredArray = stride(from: startIndex, through: array.count, by: step).map{array[$0]}
                return filteredArray
            }
        
        
    }

