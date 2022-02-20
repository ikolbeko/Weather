//
//  MainViewModel.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation
import CoreLocation

class MainViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var forecast = [Forecast]()
    let notificationCenter = NotificationCenter.default
    var reqvestManager = RequestManager()
    
    @objc func getWeatherInlocation() {
        guard let location = LocationManager.shared.location else { return }
        reqvestManager.completion = { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.setDataInForecast(from: data)
                self.setDataInWeather(from: data)
            }
        }
        reqvestManager.getWeather(inLocation: location)
        notificationCenter.removeObserver(self)
    }
    
    func getWeather(inCity city: String) {
        reqvestManager.completion = { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.setDataInForecast(from: data)
                self.setDataInWeather(from: data)
            }
        }
        reqvestManager.getWeather(inCity: city)
    }
    
    func getLocation() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getWeatherInlocation),
                                               name: NSNotification.Name("location"),
                                               object: nil)
    }
}
