//
//  MainTempView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 10.09.2023.
//

import SwiftUI


struct MainTemperatureView: View {
    var forecast: Forecast?
    @State private var opacity = true
    var body: some View {
        if let forecast {
          
                
            Text("\(Int(forecast.main.temp -  273.15))°")
                .foregroundColor(.theme.blue)
                .font(.system(size: 150))
                .padding(.leading)
                .padding(.top)
                .frame(maxHeight: 140)
                .opacity(opacity ? 0.1 : 1.0)
                .onAppear {
                    let _ = Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { timer in
                        withAnimation(.easeIn(duration: 1)) {
                            self.opacity = false
                        }
                    }
                   
                }
        }
    }
}

struct TypeOfWeather: View {
    var forecast: Forecast?
    @State private var opacity = true
    var body: some View {
        if let forecast {
            let weatherMain = forecast.weather[0].main
            Text("\(weatherMain)")
                .foregroundColor(.black)
                .opacity(opacity ? 0 : 1.0)
                .font(.subheadline)
//                .fontWeight(.bold)
                .padding()
                .onAppear {
                    let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                        withAnimation(.easeIn(duration: 1)) {
                            self.opacity = false
                        }
                    }
                   
                }
        }
    }
}

struct CityNameView: View {
//    let city: CityElement?
    var city: String
    var forecast: Forecast?
    var body: some View {
       

             
                Text(city ?? "LA")
                    .fontWeight(.black)
                    .frame(alignment: .center)
                    
                    .font(.title2)
                    .padding(.vertical)
               
                
//                Button {
//
//                } label: {
//                    Image(systemName: "line.2.horizontal.decrease.circle.fill")
//                        .font(.title)
//                        .foregroundColor(.black)
//                }
//                .offset(x: 100)
//                .padding(.trailing)

        }
    }

struct DateView: View {
    let vm: ViewModel
    @State private var opacity = true
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)

                .opacity(opacity ? 0 : 0.8)
                .frame(width: 170, height:30)
                
            HStack {
                Text(vm.now.formatted(Date.FormatStyle().weekday(.wide)) + ",")
                Text(vm.now.formatted(Date.FormatStyle().day().month(.wide)))
            }
            .foregroundColor(.theme.yellow)
            .opacity(opacity ? 0 : 1.0)
            .font(.footnote)
        }
//        .padding(.top)
        .onAppear {
            let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                withAnimation(.easeIn(duration: 1)) {
                    self.opacity = false
                }
            }
           
        }
    }
}


struct DailySummary: View {
    var forecast: Forecast?
    @State private var opacity = true
    var body: some View {
        if let forecast {
            VStack(alignment:.leading){
                HStack() {
                    Text("Daily Summary")
                        .fontWeight(.black)
                        .padding(.horizontal)
                        .padding(.top, 40)
                        .font(.title3)
                }
                
                HStack {
                    Text("Now it feels like \(Int(forecast.main.feels_like - 273.15))°, actually \(Int(forecast.main.temp - 273.15))°")
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .truncationMode(.middle)
//                        .bold()
                        .padding(.horizontal)
                    
                }
                HStack {
                    Text("The temperature range is from \(Int(forecast.main.temp_min - 273.15))° to \(Int(forecast.main.temp_max - 273.15))°")
                        .bold()
                        .padding(.horizontal)
                        
                    
                }
            }
            .onAppear {
                let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    withAnimation(.easeIn(duration: 1)) {
                        self.opacity = false
                    }
                }
               
            }
            
            .foregroundColor(.black)
            .opacity(opacity ? 0 : 1.0)
        }
    }
}


