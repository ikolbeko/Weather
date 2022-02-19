//
//  CurrentWeather.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import SwiftUI

struct CurrentWeather: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Top Components
            HStack {
                Spacer()
                Button {
                    mainViewModel.fetchData()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 25))
                        .frame(width: 44, height: 44, alignment: .center)
                }
            }
            Text(mainViewModel.weather?.cityName ?? "nil")
                .font(.largeTitle)
            Spacer()
            
            Text(mainViewModel.weather?.conditionText ?? "nil")
            
            Spacer()
            
            HStack() {
                Image(systemName: "cloud.rain.fill")
                    .font(.system(size: 100))
                Text(mainViewModel.weather?.temperature ?? "nil")
                    .font(.system(size: 50))
            }
            
            // MARK: Bottom Components
            HStack(alignment: .center) {
                VStack {
                    Label("Feelslike", systemImage: "thermometer")
                    Spacer()
                    Text(mainViewModel.weather?.feelsLike ?? "nil")
                        .font(.system(size: 18))
                }.padding(.vertical, 10.0)
                
                Spacer()
                
                VStack {
                    Label("Humidity", systemImage: "humidity")
                    Spacer()
                    Text(mainViewModel.weather?.humidity ?? "nil")
                        .font(.system(size: 18))
                }.padding(.vertical, 10.0)
                
                Spacer()
                
                VStack {
                    Label("Wind", systemImage: "wind")
                    Spacer()
                    Text(mainViewModel.weather?.windSpeed ?? "nill")
                        .font(.system(size: 18))
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