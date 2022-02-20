//
//  WeeklyForecastCell.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import SwiftUI

import SwiftUI

let contentSize = UIScreen.main.bounds.size.width / 3.5

struct WeeklyForecastCell: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            ForEach(mainViewModel.forecast) { value in
                Divider()
                HStack(alignment: .center) {
                    Text(value.date)
                        .frame(width: contentSize, height: 30, alignment: .leading)
                    HStack {
                        Image(systemName: value.weatherIcon)
                            .symbolRenderingMode(.multicolor)
                            .shadow(radius: 10)
                        Text(value.minMaxTemp)
                    }
                    .frame(width: contentSize, height: 30, alignment: .center)
                    Text(value.conditionText)
                        .frame(width: contentSize, height: 30, alignment: .trailing)
                        .font(.system(size: 15))
                }.padding(.horizontal, 30)
            }
        }
    }
}

struct WeeklyForecastCell_Previews: PreviewProvider {
    static var previews: some View {
        //WeeklyForecastCell()
        MainView()
    }
}
