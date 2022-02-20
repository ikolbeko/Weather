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
    var location = CLLocationCoordinate2D(latitude: 0, longitude: 0) {
        didSet {
            fetchWeather()
        }
    }
    
    func getWeather (inLocation location: CLLocationCoordinate2D) {
        let geoURL = "\(geoURL)reverse?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)"
        URLSession.shared.getData(url: geoURL) { (data: LocationData?) in
            guard let city = data else { return }
            self.location = location
            self.city = city.last?.name
        }
    }
    
    func getWeather (inCity city: String) {
        let searchURL = "\(geoURL)direct?q=\(city)&appid=\(apiKey)".encodeUrl
        URLSession.shared.getData(url: searchURL) { (data: LocationData?) in
            if let lat = data?.last?.lat {
                if let lon = data?.last?.lon {
                    self.location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                }
            }
            self.city = data?.last?.name
        }
    }
    
    func fetchWeather() {
        let url = "\(baseURL)?lat=\(location.latitude)&lon=\(location.longitude)&exclude=minutely,hourly&units=metric&lang=en&appid=\(apiKey)"
        URLSession.shared.getData(url: url) { (data: WeatherData?) in
            guard let data = data else { return }
            self.completion?(data)
        }
    }
}


//        let url = URL(string: "\(baseURL)?lat=\(location.latitude)&lon=\(location.longitude)&exclude=minutely,hourly&units=metric&lang=en&appid=\(apiKey)")
//        guard let url = url else { return }
//        URLSession.shared.dataTask(with: url, completionHandler: { (weather: WeatherData?, response, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            if let weather = weather {
//                self.completion?(weather)
//            }
//        }).resume()
