//
//  ContentView.swift
//  WeatherIconApp
//
//  Created by iosdev on 7.4.2023.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack {
            
            //The version with preset coordinates
            if locationManager.location != nil {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: DummyCoordinates(), longitude: DummyCoordinates())
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
                
                
                //                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
            } else {
                if locationManager.isLoading {
                    ProgressView()
                } else {
                    WelcomeView()
                    .environmentObject(locationManager)}
            }
            
            
            // The version with phone's location
            
            //            if let location = locationManager.location {
            //                if let weather = weather {
            //                    WeatherView(weather: weather)
            //                } else {
            //                        LoadingView()
            //                            .task {
            //                                do {
            //                                    weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
            //                                } catch {
            //                                    print("Error getting weather: \(error)")
            //                                }
            //                            }
            //                    }
            //
            //
            //                //                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
            //            } else {
            //                if locationManager.isLoading {
            //                    ProgressView()
            //                } else {
            //                    WelcomeView()
            //                    .environmentObject(locationManager)}
            //            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
