//
//  MainViewModel.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation
import CoreLocation

class MainViewModel: ObservableObject {
    @Published var forecast: Forecast?
    let notificationCenter = NotificationCenter.default
    var reqvestManager = RequestManager()
    
    @objc func getWeatherInMylocation() {
        guard let location = LocationManager.shared.location else { return }
        reqvestManager.getWeather(inLocation: location) { data in
            DispatchQueue.main.async {
                self.setDataInForecast(from: data)
            }
        }
        notificationCenter.removeObserver(self)
    }
    
    func getWeather(inCity city: String) {
        reqvestManager.getWeather(inCity: city) { data in
            DispatchQueue.main.async {
                self.setDataInForecast(from: data)
            }
        }
    }
    
    func getLocation() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getWeatherInMylocation),
                                               name: NSNotification.Name("location"),
                                               object: nil)
    }
}
