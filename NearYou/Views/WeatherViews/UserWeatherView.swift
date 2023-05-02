//
//  ContentView.swift
//  WeatherIconApp
//
//  Created by iosdev on 7.4.2023.
//

import SwiftUI
import CoreLocation


struct UserWeatherView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserWeatherView()
    }
}
