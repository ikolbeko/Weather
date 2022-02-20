//
//  weatherApp.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import SwiftUI

@main
struct weatherApp: App {
    let location = LocationManager.shared.location
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.dark)
        }
    }
}
