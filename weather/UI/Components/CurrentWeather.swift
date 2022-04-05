//
//  CurrentWeather.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import SwiftUI

struct CurrentWeather: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State private var cityName: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Top Components
            HStack {
                
                Button {
                    mainViewModel.getWeatherInMylocation()
                } label: {
                    Image(systemName: "location.fill")
                }
                .buttonStyle(.bordered)

                
                TextField(
                    "Search...",
                    text: $cityName
                )
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    mainViewModel.getWeather(inCity: cityName)
                    cityName = ""
                }
            }
            .padding(.top, 15)

            Text(mainViewModel.forecast?.cityName ?? "")
                .font(.largeTitle)
            Spacer()
            Text(mainViewModel.forecast?.conditionText ?? "")
            Spacer()
            HStack() {
                Image(systemName: mainViewModel.forecast?.weatherIcon ?? "")
                    .font(.system(size: 100))
                    .symbolRenderingMode(.multicolor)
                    .shadow(radius: 5)
                Text(mainViewModel.forecast?.temperature ?? "")
                    .font(.system(size: 50))
            }
            
            // MARK: Bottom Components
            HStack(alignment: .center) {
                VStack {
                    Label {
                        Text("Feelslike")
                            .multilineTextAlignment(.center)
                    } icon: {
                        Image(systemName: "thermometer")
                    }
                    
                    Spacer()
                    Text(mainViewModel.forecast?.feelsLike ?? "")
                        .font(.system(size: 18))
                }.padding(.vertical, 10.0)
                Spacer()
                VStack {
                    Label("Humidity", systemImage: "humidity")
                    Spacer()
                    Text(mainViewModel.forecast?.humidity ?? "")
                        .font(.system(size: 18))
                }.padding(.vertical, 10.0)
                Spacer()
                VStack {
                    Label("Wind", systemImage: "wind")
                    Spacer()
                    Text(mainViewModel.forecast?.windSpeed ?? "")
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
