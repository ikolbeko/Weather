//
//  ContentView.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                CurrentWeather(mainViewModel: mainViewModel)
                HStack {
                    Text("Week forecast")
                        .font(.system(size: 20))
                    Spacer()
                }.padding(.horizontal, 30).padding(.top)
                
                //MARK: Week forecast table view
                if let weekForecast = mainViewModel.forecast?.weekForecast {
                    VStack(alignment: .center) {
                        ForEach(weekForecast) { value in
                            WeeklyForecastCell(value)
                        }
                    }
                }
                
            }
        }.onAppear(perform: mainViewModel.getLocation)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
