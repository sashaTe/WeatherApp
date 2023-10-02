//
//  ForecastCardView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 23.07.2023.
//

import SwiftUI

struct ForecastCardView: View {
    let temperature: Double
    let date: String
    let image: String
    let name: String
    
    @State private var isOpacityEnabled = true
    @State private var isPresentedDetailedView = false
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.theme.black.opacity(0.8), lineWidth: 1)

            VStack(spacing:20) {
                Text("\(Int(temperature))°")
                    .font(.headline)
                    .foregroundColor(.black)
                Image(systemName: image)
                    .foregroundColor(image.switchColor())
                Text("\(date)".dayOfWeek() ?? "")
                    .foregroundColor(.black).opacity(0.9)
                    .font(.headline)
            }
            .opacity(isOpacityEnabled ? 0 : 1.0)
        }
        .fullScreenCover(isPresented: $isPresentedDetailedView, content: {
            ForecastCardDetailedView(date: date, temperature: temperature, image: image)
        })
        .onTapGesture(perform: {
            isPresentedDetailedView = true
        })
        .onAppear {
            let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                withAnimation(.easeIn(duration: 1)) {
                    self.isOpacityEnabled = false
                }
            }
           
        }
            
    }
}

struct ForecastCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCardView(temperature: 26, date: Date().formatted(date: .long, time: .omitted), image: "sun.max.fill", name: "London")
    }
}
