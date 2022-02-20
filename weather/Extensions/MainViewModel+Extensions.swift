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
        var conditionID: Int
        var temperature: String?
        var feelsLike: String?
        var humidity: String?
        var windSpeed: String?
        
        var weatherIcon: String {
            switch conditionID {
            case 200...299: return "cloud.rain.fill"
            case 300...399: return "cloud.drizzle.fill"
            case 500...599: return "cloud.sun.rain.fill"
            case 600...699: return "cloud.snow.fill"
            case 700...799: return "wind.fill"
            case 800: return "sun.max.fill"
            case 801...899: return "cloud.sun.fill"
            default: return "cloud.sun.fill"
            }
        }
    }
    
    struct Forecast: Identifiable {
        var id: UUID
        var date: String
        var conditionID: Int
        var minMaxTemp: String
        var conditionText: String
        
        var weatherIcon: String {
            switch conditionID {
            case 200...299: return "cloud.rain.fill"
            case 300...399: return "cloud.drizzle.fill"
            case 500...599: return "cloud.sun.rain.fill"
            case 600...699: return "cloud.snow.fill"
            case 700...799: return "wind.fill"
            case 800: return "sun.max.fill"
            case 801...899: return "cloud.sun.fill"
            default: return "cloud.sun.fill"
            }
        }
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
                                conditionID: value.weather.last?.id ?? 600,
                                minMaxTemp: "\(Int(value.temp.max))/\(Int(value.temp.min))°C",
                                conditionText: value.weather.last?.weatherDescription ?? "nil")
            self.forecast.append(temp)
        }
    }
    
    func setDataInWeather(from data: WeatherData) {
        let temp = Weather(cityName: self.reqvestManager.city ?? data.timezone,
                           conditionText: data.current.weather.last?.weatherDescription,
                           conditionID: data.current.weather.last?.id ?? 600,
                           temperature: "\(Int(data.current.temp))°C",
                           feelsLike: "\(Int(data.current.feelsLike))°C",
                           humidity: "\(data.current.humidity) %",
                           windSpeed: "\(data.current.windSpeed) Mph")
        
        self.weather = temp
    }
}
