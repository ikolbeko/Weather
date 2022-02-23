//
//  MainViewModel+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation
import CoreLocation

extension MainViewModel {
    
    func getFormattedDate(date: Int) -> String? {
        let dateformat = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "E, MMM d"
        return dateFormatterSet.string(from: dateformat)
    }
    
    //MARK: Set data in forecast array
    func setDataInForecast(from data: WeatherData) {
        var forecastArray = [WeekForecast]()
        for value in data.daily {
            let temp = WeekForecast(id: UUID(),
                                    date: self.getFormattedDate(date: value.dt) ?? "nil",
                                    conditionID: value.weather.last?.id ?? 600,
                                    minMaxTemp: "\(Int(value.temp.max))/\(Int(value.temp.min))°C",
                                    conditionText: value.weather.last?.weatherDescription ?? "nil")
            forecastArray.append(temp)
        }
        
        let temp = Forecast(cityName: self.reqvestManager.city ?? data.timezone,
                            humidity: "\(data.current.humidity) %",
                            feelsLike: "\(Int(data.current.feelsLike))°C",
                            windSpeed: "\(data.current.windSpeed) Mph",
                            temperature: "\(Int(data.current.temp))°C",
                            conditionID: data.current.weather.last?.id ?? 600,
                            conditionText: data.current.weather.last?.weatherDescription,
                            weekForecast: forecastArray)
        
        self.forecast = temp
    }
}
