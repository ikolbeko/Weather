//
//  CurrentWeather.swift
//  weather
//
//  Created by Илья Колбеко on 16.02.22.
//

import SwiftUI

struct CurrentWeather: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button {
                    print("")
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 25))
                        .frame(width: 44, height: 44, alignment: .center)
                }
            }
            Text("London")
                .font(.largeTitle)
            Spacer()
            
            Text("Rain")
            
            Spacer()
            
            HStack() {
                Image(systemName: "cloud.rain.fill")
                    .font(.system(size: 100))
                Text("12°")
                    .font(.system(size: 50))
                
            }
            
            // MARK: Bottom Components
            HStack(alignment: .center) {
                VStack {
                    Label("Feelslike", systemImage: "thermometer")
                    Spacer()
                    Text("12°")
                        .font(.system(size: 22))
                }.padding(.vertical, 10.0)

                Spacer()
                
                VStack {
                    Label("Humidity", systemImage: "thermometer")
                    Spacer()
                    Text("60%")
                        .font(.system(size: 22))
                }.padding(.vertical, 10.0)
                
                Spacer()
                
                VStack {
                    Label("Wind", systemImage: "thermometer")
                    Spacer()
                    Text("6 m/s")
                        .font(.system(size: 22))
                }.padding(.vertical, 10.0)
            }
        }.padding(.horizontal, 30.0)
    }
}

struct CurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        //CurrentWeather()
        MainView()
    }
}
