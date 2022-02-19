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
    let baseURL = "https://api.openweathermap.org/data/2.5/onecall"
    let apiKey = "8c9460599c7df3435d34a035e543c72a"
    
    func getWeather (inLocation location: CLLocationCoordinate2D) {
        print(location.latitude)
        print(location.longitude)
        
        let url = "\(baseURL)?lat=\(location.latitude)&lon=\(location.longitude)&exclude=minutely,hourly&units=metric&lang=en&appid=\(apiKey)"
        print(url)
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.networkDataTask(with: url) { networkData, response, error in
            if let networkData = networkData {
                self.completion?(networkData)
            }
        }
        task.resume()
    }
    
    func getWeather(inCity city: String) {
        
    }
}
