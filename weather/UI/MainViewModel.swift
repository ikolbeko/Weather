//
//  MainViewModel.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var forecast = [Forecast]()
    var reqvestManager = RequestManager()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        reqvestManager.completion = { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                var tempForecast = [Forecast]()
                
                for value in data.daily {
                    let temp = Forecast(id: UUID(),
                                        date: self.getFormattedDate(date: value.dt) ?? "nil",
                                        conditionImage: value.weather.last?.icon ?? "nil",
                                        minMaxTemp: "\(Int(value.temp.max))/\(Int(value.temp.min))°C",
                                        conditionText: value.weather.last?.weatherDescription ?? "nil")
                    tempForecast.append(temp)
                }
                self.forecast = tempForecast
                
                let temp = Weather(cityName: data.timezone,
                                   conditionText: data.current.weather.last?.weatherDescription,
                                   conditionImage: data.current.weather.last?.icon,
                                   temperature: "\(Int(data.current.temp))°C",
                                   feelsLike: "\(Int(data.current.feelsLike))°C",
                                   humidity: "\(data.current.humidity) %",
                                   windSpeed: "\(data.current.windSpeed) Mph")
                
                self.weather = temp
            }
        }
        reqvestManager.getWeather()
    }
}

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
        //guard let dateformat = dateformat else { return "error" }
        return dateFormatterSet.string(from: dateformat)
    }
}
