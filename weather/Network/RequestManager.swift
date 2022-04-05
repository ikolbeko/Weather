//
//  RequestManager.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation
import CoreLocation

class RequestManager {
    
    var city: String?
    var language = NSLocalizedString("language", comment: "en")
    let baseURL = "https://api.openweathermap.org/data/2.5/onecall"
    let geoURL = "https://api.openweathermap.org/geo/1.0/"
    let apiKey = "8c9460599c7df3435d34a035e543c72a"
    var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    
    func getWeather (inLocation location: CLLocationCoordinate2D, completion: @escaping (WeatherData) -> Void) {
        self.location = location
        let geoURL = "\(geoURL)reverse?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)"
        URLSession.shared.getData(url: geoURL) { (data: LocationData?) in
            guard let city = data?.last?.name else { return }
            self.getWeather(inCity: city) { data in
                completion(data)
            }
        }
    }
    
    func getWeather (inCity city: String, completion: @escaping (WeatherData) -> Void) {
        let searchURL = "\(geoURL)direct?q=\(city)&appid=\(apiKey)".encodeUrl
        URLSession.shared.getData(url: searchURL) { (data: LocationData?) in
            if let lat = data?.last?.lat {
                if let lon = data?.last?.lon {
                    self.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                }
            }
            if data?.last?.localNames[self.language] == nil {
                self.city = data?.last?.name
            } else {
                self.city = data?.last?.localNames[self.language]
            }
            self.fetchWeather { data in
                completion(data)
            }
        }
    }
    
    func fetchWeather(completion: @escaping (WeatherData) -> Void) {
        let url = "\(baseURL)?lat=\(location.latitude)&lon=\(location.longitude)&exclude=minutely,hourly&units=metric&lang=\(language)&appid=\(apiKey)"
        
        URLSession.shared.getData(url: url) { (data: WeatherData?) in
            guard let data = data else { return }
            completion(data)
        }
    }
}
