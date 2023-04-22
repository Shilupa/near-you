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
    
//    func fetchWeatherData(latitude: Double, longitude: Double) {
//        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("147feb2c7edb8e7e106380dff079bcab")&units=metric") else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                return
//            }
//
//            do {
//                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                DispatchQueue.main.async {
//                    let iconName = weatherData.weather.first?.icon ?? ""
//                    self.icon = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
//                    print("blabla", self.icon)
//                    print("blablalblalalal", iconName)
//                    self.temperature = weatherData.main.temp
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
 
    
    // func fetchWeatherData(for location: Location, completion: @escaping(Result<WeatherData, Error>) -> Void) {
    
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
                    //print("blabla", self.icon)
                    //print("blablalblalalal", iconName)
                    self.temperature = weatherData.main.temp
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
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let icon: String
}
