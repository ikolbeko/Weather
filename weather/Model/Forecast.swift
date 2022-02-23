//
//  Forecast.swift
//  weather
//
//  Created by Илья Колбеко on 23.02.22.
//

import Foundation

struct Forecast {
    var cityName: String?
    var humidity: String?
    var feelsLike: String?
    var windSpeed: String?
    var temperature: String?
    var conditionID: Int
    var conditionText: String?
    var weekForecast: [WeekForecast]
    
    var weatherIcon: String {
        weather.setWeatherIcon(conditionID)
    }
}

struct WeekForecast: Identifiable {
    var id: UUID
    var date: String
    var conditionID: Int
    var minMaxTemp: String
    var conditionText: String
    
    var weatherIcon: String {
        weather.setWeatherIcon(conditionID)
    }
}

func setWeatherIcon(_ conditionID: Int) -> String {
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
