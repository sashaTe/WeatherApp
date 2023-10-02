//
//  WeatherParametersView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 23.07.2023.
//


import SwiftUI




struct WeatherParametersView: View {
    
    let windSpeed: Double
    let humidityPercentage: Int
    let visibilityRange: Int
    
    
    @State private var forecast: Forecast?
    
    
    @State private var isOpacityEnabled = false
    @State private var isOffsetEnabled = false
    @State private var isOffsetTextEnabled = false
    @State private var isAllOpacityEnabled = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.8))
                .opacity(isAllOpacityEnabled ? 0 : 1.0)
            
            HStack(spacing: 50) {
                VStack {
                    Image(systemName: "wind")
                        .font(.title)
                        .padding(.bottom, 10)
                        .opacity(isOpacityEnabled ? 1.0 : 0.1)
                        .offset(isOffsetEnabled ? CGSize(width: 0, height: 0) : CGSize(width: -20, height: 0))
                    Group {
                        Text("\(Int(windSpeed)) km/h")
                            .bold()
                        Text("Wind")
                            .font(.callout)
                    }
                }
                VStack {
                    Image(systemName: "drop")
                    
                        .font(.title)
                        .padding(.bottom, 10)
                        .opacity(isOpacityEnabled ? 1.0 : 0.1)
                        .offset(isOffsetEnabled ? CGSize(width: 0, height: 0) : CGSize(width: 0, height: -20))
                    Group {
                        Text("\(humidityPercentage) %")
                            .bold()
                        Text("Humidity")
                            .font(.callout)
                    }
                }
                VStack {
                    Image(systemName: "eye")
                        .font(.title)
                        .padding(.bottom, 10)
                        .opacity(isOpacityEnabled ? 1.0 : 0.1)
                        .offset(isOffsetEnabled ? CGSize(width: 0, height: 0) : CGSize(width: 20, height: 0))
                    Group {
                        Text("\(visibilityRange / 1000) km")
                            .bold()
                        Text("Visibility")
                            .font(.callout)
                    }
                }
                
            }
            .foregroundColor(.theme.yellow)
            .padding()
            .onAppear {
                let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                    withAnimation(.easeIn(duration: 1)) {
                        self.isOpacityEnabled = true
                        self.isOffsetEnabled = true
                    }
                }
                let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                    withAnimation(.easeIn(duration: 1)) {
                        self.isAllOpacityEnabled = false
                    }
                }
            }
        }
    }
}




struct WeatherParametersView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherParametersView(windSpeed: 1.0, humidityPercentage: 2, visibilityRange: 3)
    }
}


