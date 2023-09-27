//
//  Date.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 26.07.2023.
//

import Foundation

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var twoDaysAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: self)!
    }
    var threeDaysAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 3, to: self)!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}
