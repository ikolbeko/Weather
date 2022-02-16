//
//  ContentView.swift
//  weather
//
//  Created by Илья Колбеко on 16.02.22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView {
            CurrentWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
