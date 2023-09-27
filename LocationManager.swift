//
//  LocationManager.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 25.09.2023.
//

import MapKit

@MainActor
class LocationManager: NSObject, ObservableObject {
    
    @Published var userLocation: CLLocation?
    @Published var userRegion = MKCoordinateRegion()
    
    
    private let manager = CLLocationManager()
    
    static let shared = LocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter  = kCLDistanceFilterNone
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()  // Remember to update Info.plist!
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        @unknown default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation  = location
        self.userRegion    = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}
