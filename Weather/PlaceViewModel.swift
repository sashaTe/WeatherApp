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
    
    @Published var places: [Place] = []
    @Published var currentCity: City?
    @Published var cities: [City] = []
    @Published var weeklyForecast = [WeatherInfo]()
    @Published var weekly: Weekly?
    
    func search(text: String) { //region: MKCoordinateRegion) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        searchRequest.naturalLanguageQuery = text
//        searchRequest.resultTypes = .address
        
//        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {print(error?.localizedDescription ?? "")
                return
            }
            
            self.places = response.mapItems.map(Place.init)
        }
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
        self.cities.append(city)
    }
    
    func getWeather(lat: Double, lon: Double) async throws -> Forecast {

        let endpoint = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=3e01a065727a146c0c658097d813e039"
        
        print(endpoint)
    
        guard let url = URL(string: endpoint) else {throw CityError.invalidURL}
        
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)
        
//         DEBUG
//                if let jsonString = String(data: data, encoding: .utf8) {
//                       print("API Response:", jsonString) // Print the API response as a JSON string
//                   } else {
//                       print("Failed to convert API response to JSON string.")
//                   }
//
        
        guard let response = response as?HTTPURLResponse, response.statusCode == 200 else { print("bad getweather response")
            throw CityError.invalidResponse}
        
        do {
            let decoder = JSONDecoder()
            let forecast = try decoder.decode(Forecast.self, from: data)
//            let name = forecast.name
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
