//
//  WeatherManager.swift
//  WeatherIconApp
//
//  Created by iosdev on 7.4.2023.
//

import Foundation
import CoreLocation

/*
 Weather Manager to get the weather data of current location
 */
class WeatherManager: ObservableObject {
    
        func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("147feb2c7edb8e7e106380dff079bcab")&units=metric") else { fatalError("Missing URL")}

            let urlRequest = URLRequest(url: url)

            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}

            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)

            return decodedData
        }
    
}

// Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
extension ResponseBody.WeatherResponse {
    var weatherIcon: String { return icon}
}
