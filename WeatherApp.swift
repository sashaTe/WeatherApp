//
//  WeatherApp.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 21.07.2023.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var vm = ViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var placeVm = PlaceViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
//                ContentView(cityName: vm.locations.first ?? "")
            }
            .environmentObject(vm)
            .environmentObject(locationManager)
            .environmentObject(placeVm)
        }
        
    }

}
