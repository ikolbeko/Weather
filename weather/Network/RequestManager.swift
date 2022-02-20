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
        
        let geoURL = "\(geoURL)reverse?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(apiKey)"
        URLSession.shared.getData(url: geoURL) { (data: LocationData?) in
            guard let city = data else { return }
            self.city = city.last?.name
        }
        
        let url = "\(baseURL)?lat=\(location.latitude)&lon=\(location.longitude)&exclude=minutely,hourly&units=metric&lang=en&appid=\(apiKey)"
        URLSession.shared.getData(url: url) { (data: WeatherData?) in
            guard let data = data else { return }
            self.completion?(data)
        }
    }
    
    func getWeather (inCity city: String) {
        var latitude: Double = 0
        var longtitude: Double = 0
        
        let searchURL = "\(geoURL)direct?q=\(city)&appid=\(apiKey)"
        URLSession.shared.getData(url: searchURL) { (data: LocationData?) in
            guard let lat = data?.last?.lat else { return }
            guard let lon = data?.last?.lon else { return }
            latitude = lat
            longtitude = lon
        }
        
        let url = "\(baseURL)?lat=\(latitude)&lon=\(longtitude)&exclude=minutely,hourly&units=metric&lang=en&appid=\(apiKey)"
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
