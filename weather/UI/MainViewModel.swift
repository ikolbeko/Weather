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
    private let notificationCenter = NotificationCenter.default
    var reqvestManager = RequestManager()
    
    @objc func fetchData() {
        guard let location = LocationManager.shared.location else { return }
        
        reqvestManager.completion = { [weak self] data in
            DispatchQueue.main.async {
                
                guard let self = self else { return }
                for value in data.daily {
                    let temp = Forecast(id: UUID(),
                                        date: self.getFormattedDate(date: value.dt) ?? "nil",
                                        conditionImage: value.weather.last?.icon ?? "nil",
                                        minMaxTemp: "\(Int(value.temp.max))/\(Int(value.temp.min))°C",
                                        conditionText: value.weather.last?.weatherDescription ?? "nil")
                    self.forecast.append(temp)
                }
                
                let temp = Weather(cityName: self.reqvestManager.city ?? data.timezone,
                                   conditionText: data.current.weather.last?.weatherDescription,
                                   conditionImage: data.current.weather.last?.icon,
                                   temperature: "\(Int(data.current.temp))°C",
                                   feelsLike: "\(Int(data.current.feelsLike))°C",
                                   humidity: "\(data.current.humidity) %",
                                   windSpeed: "\(data.current.windSpeed) Mph")
                
                self.weather = temp
            }
        }
        reqvestManager.getWeather(inLocation: location)
        notificationCenter.removeObserver(self)
    }
    
    func getLocation() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fetchData),
                                               name: NSNotification.Name("location"),
                                               object: nil)
    }
}
