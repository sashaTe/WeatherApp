//
//  ViewModel.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 21.07.2023.
//

import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @EnvironmentObject private var locationManagerr: LocationManager
    var week: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var tomorrow = Date().dayAfter
    var afterTomorrow = Date().twoDaysAfter
    var afterAfterTomorrow = Date().threeDaysAfter
    @Published var locations =  [String]()
    @Published var now = Date()
    @Published var days: [Date] = []
    @Published var weeklyForecast = [WeatherInfo]()
    @Published var lat: Double?
    @Published var lon: Double?

    
    init()  {
        self.now = now
        self.days = [tomorrow, afterTomorrow, afterAfterTomorrow]
  
    }
    
     func appendCurrentCity() async throws -> String {
         let lat = LocationManager.shared.userLocation?.coordinate.latitude
         print("\(String(describing: lat))")
         
         
         let latDouble = Double(lat ?? 0.0)
         print(latDouble)
        
         let lon = LocationManager.shared.userLocation?.coordinate.longitude
         let lonDouble = Double(lon ?? 0.0)
         print(lonDouble)
         
         let endpoint = "https://api.openweathermap.org/data/2.5/weather?lat=\(latDouble)&lon=\(lonDouble)&appid=3e01a065727a146c0c658097d813e039"
         print(endpoint)

     
         guard let url =  URL(string: endpoint) else {throw CityError.invalidURL}
         
         print(url)
         let (data, response) = try await URLSession.shared.data(from: url)
         
 //         DEBUG
 //                if let jsonString = String(data: data, encoding: .utf8) {
 //                       print("API Response:", jsonString) // Print the API response as a JSON string
 //                   } else {
 //                       print("Failed to convert API response to JSON string.")
 //                   }
 //
         
         guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             print("bad append response")
             throw CityError.invalidResponse}
         
         do {
             let decoder = JSONDecoder()
             let forecast = try decoder.decode(Forecast.self, from: data)
             let name = forecast.name
             print("name is \(name)")
             locations.append(name)
             return name
         } catch {
             print("Decoding Error:", error)
             throw CityError.invalidData
         }
    }
    
    func getCity(name: String) async throws -> [CityElement] {
        let endpoint = "https://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=1&appid=3e01a065727a146c0c658097d813e039"
        print(endpoint)
        guard let url = URL(string: endpoint) else {throw CityError.invalidURL}
        
        //        print(url)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // DEBUG
        //        if let jsonString = String(data: data, encoding: .utf8) {
        //               print("API Response:", jsonString) // Print the API response as a JSON string
        //           } else {
        //               print("Failed to convert API response to JSON string.")
        //           }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { print("bad getCity response")
            throw CityError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([CityElement].self, from: data)
        } catch {
            print("Decoding Error:", error)
            throw CityError.invalidData
        }
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
            let name = forecast.name
            locations.append(name)
            return forecast
        } catch {
            print("Decoding Error:", error)
            throw CityError.invalidData
        }
    }
    
    func getFiveDayForecast(lat: Double, lon: Double) async throws -> Weekly {
        let endpoint = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=3e01a065727a146c0c658097d813e039"
        
        guard let url = URL(string: endpoint) else {throw CityError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {throw CityError.invalidResponse}
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Weekly.self, from: data)
            let array = filterArray(array: result.list)
            DispatchQueue.main.async {
                self.weeklyForecast = array
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
