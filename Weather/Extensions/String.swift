//
//  String.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 10.09.2023.
//

import Foundation
import SwiftUI

extension String {
    func weatherIcon() -> String {
          switch self {
          case "Clear":
              return "sun.max.fill"
          case "Clouds":
              return "cloud.fill"
          case "Rain":
              return "cloud.rain.fill"
          default:
              return "questionmark.circle.fill"
          }
      }
}

extension String {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.weekday], from: date)
            
            if let weekday = components.weekday {
                return DateFormatter().shortWeekdaySymbols[weekday - 1]
            }
        }
        
        return nil
    }
}

extension String {
    func month() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: self) {
                   let monthFormatter = DateFormatter()
                   monthFormatter.dateFormat = "MMMM" // Full month name

                   
                   let month = monthFormatter.string(from: date)

                   return month
               }
               
               return nil
           }
       }

extension String {
    func day() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: self) {

                   let dayFormatter = DateFormatter()
                   dayFormatter.dateFormat = "dd" // Day of the month

                   

                   let day = dayFormatter.string(from: date)

                   
                   return day
               }
               
               return nil
           }
       }

extension String {
    func weekday() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: self) {

                   let weekdayFormatter = DateFormatter()
                   weekdayFormatter.dateFormat = "EEEE" // Full weekday name

                   

                   let day = weekdayFormatter.string(from: date)

                   
                   return day
               }
               
               return nil
           }
       }


extension String {
    func switchColor() -> Color {
        switch self {
        case "sun.max.fill":
            return Color.theme.blue
        case "cloud.fill":
            return Color.white
        case "cloud.rain.fill":
            return Color.theme.purple
        default:
            return Color.black
        }
    }
}


