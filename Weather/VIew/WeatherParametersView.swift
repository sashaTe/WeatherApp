//
//  WeatherParametersView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 23.07.2023.
//


import SwiftUI




struct WeatherParametersView: View {
    @EnvironmentObject private var vm: ViewModel
    @State private var forecast: Forecast?
    let speedOfWind: Double
    let humidityPercent: Int
    let visibilityRange: Int
    @State private var opacity = false
    @State private var foregroundColor = false
    @State private var offset = false
    @State private var opacityText = true
    @State private var offsetText = false
    @State private var opacityAll = true

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.8))
                .opacity(opacityAll ? 0 : 1.0)

                HStack(spacing: 50) {
                    VStack {
                        Image(systemName: "wind")
                            .font(.title)
                            .padding(.bottom, 10)
                            .opacity(opacity ? 1.0 : 0.1)
                            .offset(offset ? CGSize(width: 0, height: 0) : CGSize(width: -20, height: 0))
                        Group {
                            Text("\(Int(speedOfWind)) km/h")
                                .bold()
                            Text("Wind")
                                .font(.callout)
                        }
                        .opacity(opacityText ? 1.0 : 0.1)
                    }
                    
                    VStack {
                        Image(systemName: "drop")
                       
                            .font(.title)
                            .padding(.bottom, 10)
                            .opacity(opacity ? 1.0 : 0.1)
                            .offset(offset ? CGSize(width: 0, height: 0) : CGSize(width: 0, height: -20))

                        Group {
                            Text("\(humidityPercent) %")
                                .bold()
                            Text("Humidity")
                                .font(.callout)
                        }
                        .opacity(opacityText ? 1.0 : 0.1)
                    }
                    
                   
                   
                    
                    VStack {
                        Image(systemName: "eye")
                            .font(.title)
                            .padding(.bottom, 10)
                            .opacity(opacity ? 1.0 : 0.1)
                            .offset(offset ? CGSize(width: 0, height: 0) : CGSize(width: 20, height: 0))
                        Group {
                            Text("\(visibilityRange / 1000) km")
                                .bold()
                            Text("Visibility")
                                .font(.callout)
                        }
                        .opacity(opacityText ? 1.0 : 0.1)
                    }
                    
            }
                .foregroundColor(.theme.yellow)
                
                
                .padding()

                .onAppear {
                    let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                        withAnimation(.easeIn(duration: 1)) {
                            self.opacity = true
                            self.offset = true
                           

                        }
                    }
                    let _ = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { timer in
                        withAnimation(.easeIn(duration: 1.5)){
//                            self.opacityText.toggle()
                        }
                    }
                }
        }
        .onAppear {
            let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                withAnimation(.easeIn(duration: 1)) {
                    self.opacityAll = false
                }
            }
           
        }
        
    }
}




struct WeatherParametersView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherParametersView(speedOfWind: 1.0, humidityPercent: 2, visibilityRange: 3)
    }
}


// Модификатор для вертикальной анимации
struct VerticalAnimationModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .offset(y: -50) // Изначальное вертикальное смещение
    }
}
