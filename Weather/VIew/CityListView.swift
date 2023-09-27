//
//  CityView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 09.08.2023.
//

import SwiftUI

struct CityListView: View {
    @StateObject var CitiViewModel = CitiesViewModel()
    var body: some View {
//        Text(CitiViewModel.cities[0].city)
        Text("")
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView()
    }
}
