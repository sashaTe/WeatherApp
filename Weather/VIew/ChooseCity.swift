//
//  ChooseCity.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 09.09.2023.
//

import SwiftUI

struct ChooseCity: View {
    @State private var textFieldText = ""
    @AppStorage ("city") var cityName = ""
    @State private var goToMainView = false
    var body: some View {
        NavigationView {
            ZStack {
               Color.theme.yellow
                   .ignoresSafeArea()
               VStack {
                   
                   TextField("Choose a place", text: $textFieldText)
                       .font(.largeTitle)
//                       .bold()
                       .padding(.horizontal)
                   
                   Button {
                       cityName = textFieldText
                       goToMainView = true
                       print(cityName)
                       
                      
                   } label: {
                       Text("GO")
                           .foregroundColor(.theme.yellow)
                           .background {
                               RoundedRectangle(cornerRadius: 10)
                                   .fill(.black)
                                   .frame(width: 100, height: 50, alignment: .center)
                       }
                    }
                   .padding()
//                   NavigationLink("", destination: ContentView(cityName: cityName), isActive: $goToMainView)
                   }
                   .padding()
               }
               

            }
        }
    }

struct ChooseCity_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCity()
    }
}
