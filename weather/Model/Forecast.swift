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
    
    var currentWeatherIcon: String {
        conditionID.getWeatherIcon()
    }
}

struct WeekForecast: Identifiable {
    var id: UUID
    var date: String
    var conditionID: Int
    var minMaxTemp: String
    var conditionText: String
    
    var weatherIcon: String {
        conditionID.getWeatherIcon()
    }
}

func getFormattedDate(date: Int) -> String? {
    let dateformat = Date(timeIntervalSince1970: TimeInterval(date))
    let dateFormatterSet = DateFormatter()
    dateFormatterSet.dateFormat = "E, d MMM"
    return dateFormatterSet.string(from: dateformat)
}
