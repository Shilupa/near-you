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
                            //                        .background(Color.gray)
                        }, placeholder: {
                            ProgressView()
                        })
        
                        Text(weather.main.temp.roundDouble() + "°")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                    }
//                    .padding()
//                    .background(Color.white .cornerRadius(10) .shadow(radius: 10))
        
        
        
        
        
//        //the small card withicon and temperature
//        Button {
//            showingPopover = true
//        } label: {
//            HStack {
//                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/" +  weather.weather[0].icon + "@2x.png"), content: { image in image
//                        .resizable()
//                        .aspectRatio(contentMode:.fit)
//                        .frame(maxWidth: 150, maxHeight: 150)
//                    //                        .background(Color.gray)
//                }, placeholder: {
//                    ProgressView()
//                })
//
//                Text(weather.main.temp.roundDouble() + "°")
//                    .font(.system(size: 40))
//                    .fontWeight(.bold)
//            }
//            .padding()
//            .background(Color.white .cornerRadius(10) .shadow(radius: 10))
//        }
//        //The card for the detailed view with min and max temp, wind and humidity
//        .popover(isPresented: $showingPopover) {
//            VStack {
//                VStack(spacing: 5) {
//                    Text(weather.name)
//                        .font(.largeTitle)
//                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
//                        .fontWeight(.light)
//                    HStack {
//                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/" +  weather.weather[0].icon + "@2x.png"), content: { image in image
//                                .resizable()
//                                .aspectRatio(contentMode:.fit)
//                                .frame(maxWidth: 150, maxHeight: 150)
//                        }, placeholder: {
//                            ProgressView()
//                        })
//                        VStack {
//                            Text(weather.main.temp.roundDouble() + "°")
//                                .font(.system(size: 70))
////                                .background(Color.gray)
////                                .frame(maxWidth: .infinity)
////                                .border(Color.blue)
//                            Text("Feels like " + weather.main.feelsLike.roundDouble() + "°")
//                        }
//                        .frame(width:150)
////                        .border(Color.red)
//
//
//                    }
//                    VStack {
//                        HStack {
//                            Spacer()
//                            WeatherItem(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°C"))
//                            Spacer()
//                            WeatherItem(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°C"))
//                            Spacer()
//                        }
//                        HStack {
//                            Spacer()
//                            WeatherItem(logo: "wind", name: "Wind", value: (weather.wind.speed.roundDouble() + "m/s"))
//                            Spacer()
//                            WeatherItem(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
//                            Spacer()
//                        }
//                    }.padding()
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color(hue: 0.08, saturation: 1.0, brightness: 1.0, opacity: 0.996))
//                .foregroundColor(.white)
//                Spacer()
//            }
//        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
