//
//  Place.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 26.09.2023.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID().uuidString
    private var mapItem: MKMapItem
    
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    var name: String {
        self.mapItem.name ?? ""
    }
    
    var city: String {
        let placemark = self.mapItem.placemark
        let city = placemark.locality ?? ""
        
        return city
    }
    
    var lat: Double {
        self.mapItem.placemark.coordinate.latitude
    }
    
    var lon: Double {
        self.mapItem.placemark.coordinate.longitude
    }
}
