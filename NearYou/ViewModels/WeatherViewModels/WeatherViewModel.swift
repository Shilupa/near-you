//
//  WeatherViewModel.swift
//  NearYou
//
//  Created by iosdev on 19.4.2023.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var icon: String = ""
    @Published var temperature: Double = 0
    @Published var minTemperature: Double = 0
    @Published var maxTemperature: Double = 0
    @Published var humidity: Double = 0
    @Published var windSpeed: Double = 0
    @Published var feelsLike: Double = 0

    
    func fetchWeatherData(location: Location) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\("147feb2c7edb8e7e106380dff079bcab")&units=metric") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    let iconName = weatherData.weather.first?.icon ?? ""
                    self.icon = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
                    self.temperature = weatherData.main.temp
                    self.minTemperature = weatherData.main.temp_min
                    self.maxTemperature = weatherData.main.temp_max
                    self.humidity = weatherData.main.humidity
                    self.feelsLike = weatherData.main.feels_like
                    self.windSpeed = weatherData.wind.speed
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    var wind: WindResponse
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct Weather: Codable {
    let id: Int
    let icon: String
}

struct WindResponse: Codable {
    let speed: Double
    let deg: Double
}
