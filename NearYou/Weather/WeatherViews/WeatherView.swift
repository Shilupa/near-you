//
//  WeatherView.swift
//  WeatherIconApp
//
//  Created by iosdev on 7.4.2023.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    @State private var showingPopover = false
    
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/" +  weather.weather[0].icon + "@2x.png"), content: { image in image
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                    .frame(maxWidth: 80, maxHeight: 80)
            }, placeholder: {
                ProgressView()
            })
            
            Text(weather.main.temp.roundDouble() + "°")
                .font(.system(size: 30))
                .fontWeight(.bold)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
