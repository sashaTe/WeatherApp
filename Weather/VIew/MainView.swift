//
//  MainView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 26.09.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var placeVM: PlaceViewModel
    @State private var searchPage = false

    var testArray = ["London", "Paris", "Amsterdam"]
    var body: some View {
        
        ZStack {
            Color.theme.yellow
                .ignoresSafeArea()
            VStack {
                TabView {
                    ForEach(placeVM.cities) { city in
                        ContentView(lat: city.coordinates?.latitude ?? 55.750446, lon: city.coordinates?.longitude ?? 37.617494, cityName: city.name ?? "")
                    }
                }
            }
            
        }
       

        .fullScreenCover(isPresented: $searchPage, content: {
            CityCardView()
        })
                    .toolbar {
                        ToolbarItem() {
                            Button {
                                self.searchPage = true
                            } label: {
                                Image(systemName: "line.2.horizontal.decrease.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.black)
                            }
        
        
                        }
        
                    }
//        .ignoresSafeArea()

        .tabViewStyle(.page)
        .onAppear {
            try? placeVM.loadCities()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PlaceViewModel())
    }
}
