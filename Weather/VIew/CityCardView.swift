//
//  CityCardView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 10.09.2023.
//

import SwiftUI
import MapKit


struct CityCardView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var placeVm: PlaceViewModel
    @State private var searchable = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: ViewModel
//    @Binding var returnedPlace: Place
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                  .fill(Color.theme.yellow)
                  .ignoresSafeArea()
                  .background(.thinMaterial)

                ScrollView {
                    if !searchable.isEmpty {
                        Text(placeVm.currentCity?.country ?? "")
                        Text(placeVm.currentCity?.name ?? "")
                        let lat = placeVm.currentCity?.coord_lat
                        let lon = placeVm.currentCity?.coordinates?.longitude
                        
                        Text(String(lat ?? 0.0))
                        Text(String(lon ?? 0.0))
                        if let city = placeVm.currentCity {
                            Button {
                                placeVm.addCity(city: city)
                                try? placeVm.saveCities()
                                searchable = ""
                            } label: {
                                Text("Add city")
                            }
                        }
                        
                        Divider()
                    }
                    VStack {
                        ScrollView {
                            ForEach(placeVm.cities) { city in
                                CityCard(city: city.name ?? "")
                                    .padding(.horizontal)
//                                    .frame(width: 200, height: 100)
                            }
                        }
                    }
                
            
//                VStack {
//                    ForEach(placeVm.places) {
//                        place in
//                        VStack(content: {
//                            Text(place.name)
//                            Text(place.city)
//                            Text("\(place.lat)")
//                            Text("\(place.lon)")
//                            Divider()
//                        })
//                            .onTapGesture {
//                               returnedPlace = place
//                                dismiss()
//                            }
//
//                    }
                }
            }
//                List(placeVm.places) {
//                    place in
//                    VStack {
//                        Text(place.city)
//                        Text("\(place.lat)")
//                        Text("\(place.lon)")
//                    }
//
//                }

//            }
            .onAppear {
//                try? placeVm.loadCities()
            }
            .searchable(text: $searchable)
            .onSubmit {
                withAnimation {
                    placeVm.searchCities(text: searchable)
                }
                
            }
            .onChange(of: searchable) { text in
                if !text.isEmpty {
                    placeVm.searchCities(text: text)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.black)
//                            .padding(.bottom)
                    }

                }
            }
        }

    }
}

struct CityCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CityCardView()//returnedPlace: .constant(Place(mapItem: MKMapItem())))
//                .environment(\.dismiss)
                .environmentObject(ViewModel())
                .environmentObject(LocationManager())
        }
    }
}

struct CityCard: View {
    var city: String
    @State private var goToMainView = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 4)
                .frame(height: 150)
                .foregroundColor(.theme.yellow)
                .background(.ultraThinMaterial)
                
            
            VStack(spacing: 15){
                HStack{
                    Text(city)
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                    Text("29")
                        .font(.system(size: 40))
                        .foregroundColor(.theme.blue)

                }
                HStack {
                    
                    Image(systemName: "sun.max")
                        .foregroundColor(.theme.blue)
                        .font(.largeTitle)
                }
                HStack {
                    Text("Clear")
                        .foregroundColor(.white)
                    Spacer()
                    Group{
                        HStack {
                            Text("min:")
                            Text("23, ")
                        }
                        HStack {
                            Text("max:")
                            Text("25")
                        }
                    }
                    .foregroundColor(.white)
                }
                
                
            }
            .padding()
//            NavigationLink("", destination: ContentView(cityName: city), isActive: $goToMainView)
        }
        .onTapGesture {
//            goToMainView = true
            
        }
  
        //        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//
//                } label: {
//                    Image(systemName: "plus.circle.fill")
//                        .foregroundColor(Color.theme.blue)
//                        .font(.largeTitle)
//                }
//
//            }
//        }
    }
}
