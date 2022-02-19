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
}
