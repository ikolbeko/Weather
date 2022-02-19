//
//  WeeklyForecastCell.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import SwiftUI

import SwiftUI

struct WeeklyForecastCell: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        
        VStack {
            ForEach(mainViewModel.forecast) { value in
                Divider()
                HStack {
                    Text(value.date)
                    Spacer()
                    Image(systemName: "cloud.sun.fill")
                    Text(value.minMaxTemp)
                    Spacer()
                    Text(value.conditionText)
                }.padding(.horizontal, 30.0).padding(.vertical, 15)
            }
        }
    }
}

//struct WeeklyForecastCell_Previews: PreviewProvider {
//    static var previews: some View {
//        WeeklyForecastCell()
//    }
//}
