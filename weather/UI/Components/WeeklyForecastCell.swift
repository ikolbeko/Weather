//
//  WeeklyForecastCell.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import SwiftUI

let contentSize = UIScreen.main.bounds.size.width / 3.5

struct WeeklyForecastCell: View {
    let forecast: WeekForecast
    
    init (_ value: WeekForecast) {
        forecast = value
    }
    
    var body: some View {
            Divider()
            HStack(alignment: .center) {
                Text(forecast.date)
                    .frame(width: contentSize, height: 30, alignment: .leading)
                HStack {
                    Image(systemName: forecast.weatherIcon)
                        .symbolRenderingMode(.multicolor)
                        .shadow(radius: 10)
                    Text(forecast.minMaxTemp)
                }
                .frame(width: contentSize, height: 30, alignment: .center)
                Text(forecast.conditionText)
                    .frame(width: contentSize, height: 30, alignment: .trailing)
                    .font(.system(size: 15))
            }.padding(.horizontal, 30)
    }
}

struct WeeklyForecastCell_Previews: PreviewProvider {
    static var previews: some View {
        //WeeklyForecastCell()
        MainView()
    }
}
