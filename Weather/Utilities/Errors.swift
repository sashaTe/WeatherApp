//
//  Errors.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 27.09.2023.
//

import Foundation

enum CityError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
