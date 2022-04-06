//
//  Int+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 6.04.22.
//

import Foundation

extension Int {
    
    func getWeatherIcon() -> String {
        switch self {
        case 200...299: return "cloud.rain.fill"
        case 300...399: return "cloud.drizzle.fill"
        case 500...599: return "cloud.sun.rain.fill"
        case 600...699: return "cloud.snow.fill"
        case 700...799: return "wind"
        case 800: return "sun.max.fill"
        case 801...899: return "cloud.sun.fill"
        default: return "cloud.sun.fill"
        }
    }
}
