//
//  RequestManager.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation
import CoreLocation

class RequestManager {
    var completion: ((WeatherData) -> Void)?
    var city: String?
    let baseURL = "https://api.openweathermap.org/data/2.5/onecall"
    let geoURL = "https://api.openweathermap.org/geo/1.0/"           
    let apiKey = "8c9460599c7df3435d34a035e543c72a"
    
    func getWeather (inLocation location: CLLocationCoordinate2D) {
        
        let geoURL = URL(string: "https://api.openweathermap.org/geo/1.0/reverse?lat=\(location.latitude)&lon=\(location.longitude)&appid=8c9460599c7df3435d34a035e543c72a")
        if let geoURL = geoURL {
            URLSession.shared.dataTask(with: geoURL, completionHandler: { (city: LocationData?, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let city = city?.last?.name {
                    self.city = city
                }
            }).resume()
        }
        
        let url = URL(string: "\(baseURL)?lat=\(location.latitude)&lon=\(location.longitude)&exclude=minutely,hourly&units=metric&lang=en&appid=\(apiKey)")
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (weather: WeatherData?, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let weather = weather {
                self.completion?(weather)
            }
        }).resume()
    }
    
    func getWeather(inCity city: String) {
        
    }
}
