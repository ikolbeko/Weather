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
    
    func getWeather () {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=minutely,hourly&units=metric&lang=en&appid=8c9460599c7df3435d34a035e543c72a"
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.networkDataTask(with: url) { networkData, response, error in
            if let networkData = networkData {
                self.completion?(networkData)
            }
        }
        task.resume()
    }
}
