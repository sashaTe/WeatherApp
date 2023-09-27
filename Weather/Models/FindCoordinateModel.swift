//
//  FindCoordinate.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 21.07.2023.
//

import Foundation

struct CityElement: Codable {
    let name: String
    let localNames: [String: String]
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}


