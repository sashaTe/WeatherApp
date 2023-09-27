//
//  WeeklyForecastModel.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 09.09.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weeekly = try? JSONDecoder().decode(Weeekly.self, from: jsonData)

//import Foundation
//
//// MARK: - Weeekly
//struct Weekly: Codable {
//    let cod: String
//    let message, cnt: Int
//    let list: [DaysForecast]
//    let city: Cityy
//}
//
//// MARK: - City
//struct Cityy: Codable {
//    let id: Int
//    let name: String
//    let coord: Coord
//    let country: String
//    let population, timezone, sunrise, sunset: Int
//}
//
//// MARK: - Coord
//struct Coord: Codable {
//    let lat, lon: Double
//}
//
//// MARK: - List
//struct DaysForecast: Codable {
//    let dt: Int
//    let main: MainClass
//    let weather: [Weather]
//    let clouds: Clouds
//    let wind: Wind
//    let visibility: Int
//    let pop: Double
//    let sys: Sys
//    let dtTxt: String
//    let rain: Rain?
//
//    enum CodingKeys: String, CodingKey {
//        case dt, main, weather, clouds, wind, visibility, pop, sys
//        case dtTxt = "dt_txt"
//        case rain
//    }
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}
//
//// MARK: - MainClass
//struct MainClass: Codable {
//    let temp, feelsLike, tempMin, tempMax: Double
//    let pressure, seaLevel, grndLevel, humidity: Int
//    let tempKf: Double
//
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case pressure
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
//        case humidity
//        case tempKf = "temp_kf"
//    }
//}
//
//// MARK: - Rain
//struct Rain: Codable {
//    let the3H: Double
//
//    enum CodingKeys: String, CodingKey {
//        case the3H = "3h"
//    }
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//    let pod: Pod
//}
//
//enum Pod: String, Codable {
//    case d = "d"
//    case n = "n"
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int
//    let main: MainEnum
//    let description: Description
//    let icon: String
//}
//
//enum Description: String, Codable {
//    case brokenClouds = "broken clouds"
//    case clearSky = "clear sky"
//    case fewClouds = "few clouds"
//    case lightRain = "light rain"
//    case overcastClouds = "overcast clouds"
//    case scatteredClouds = "scattered clouds"
//}
//
//enum MainEnum: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int
//    let gust: Double
//}

import SwiftUI

struct Weekly: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherInfo]
    let city: Cityy
}

struct WeatherInfo: Codable, Hashable {
    let dt: Int
    let main: MainWeatherInfo
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dt_txt: String
}

struct MainWeatherInfo: Codable, Hashable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}

struct Weather: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable, Hashable {
    let all: Int
}

struct Wind: Codable, Hashable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Sys: Codable, Hashable {
    let pod: String
}

struct Cityy: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}
