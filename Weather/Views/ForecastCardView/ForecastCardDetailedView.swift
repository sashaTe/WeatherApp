//
//  ForecastCardDetailedView.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 25.09.2023.
//

import SwiftUI

struct ForecastCardDetailedView: View {
    @Environment(\.dismiss) private var dismiss
    
    var date: String
    var temperature: Double
    var image: String
    
    var body: some View {
        ZStack {
            Color.theme.yellow
                .ignoresSafeArea()
            VStack {
                Text("\(Int(temperature))°")
                    .font(.system(size: 100))
                Image(systemName: image)
                    .font(.system(size: 100))
                    .foregroundColor(image.switchColor())
                
                Text(date.weekday() ?? "")
                HStack {
                    Text(date.month() ?? "")
                    Text(date.day() ?? "")
                }
            }
            
        }
        .onTapGesture {
                dismiss()
            }
    }
}

struct ForecastCardDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCardDetailedView(date: "2023-09-25 15:50:50", temperature: 21.0000, image: "sun.max.fill")
    }
}
