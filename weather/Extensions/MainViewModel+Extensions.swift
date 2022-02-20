//
//  MainViewModel+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation
import CoreLocation

extension MainViewModel {
    
    struct Weather {
        var cityName: String?
        var conditionText: String?
        var conditionImage: String?
        var temperature: String?
        var feelsLike: String?
        var humidity: String?
        var windSpeed: String?
    }
    
    struct Forecast: Identifiable {
        var id: UUID
        var date: String
        var conditionImage: String
        var minMaxTemp: String
        var conditionText: String
    }
    
    func getFormattedDate(date: Int) -> String? {
        let dateformat = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "E, MMM d"
        return dateFormatterSet.string(from: dateformat)
    }
    
    func setDataInForecast(from data: WeatherData) {
        self.forecast = [Forecast]()
        for value in data.daily {
            let temp = Forecast(id: UUID(),
                                date: self.getFormattedDate(date: value.dt) ?? "nil",
                                conditionImage: value.weather.last?.icon ?? "nil",
                                minMaxTemp: "\(Int(value.temp.max))/\(Int(value.temp.min))°C",
                                conditionText: value.weather.last?.weatherDescription ?? "nil")
            self.forecast.append(temp)
        }
    }
    
    func setDataInWeather(from data: WeatherData) {
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
