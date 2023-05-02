//
//  WeatherWithAPICoordinates.swift
//  NearYou
//
//  Created by iosdev on 19.4.2023.
//

import SwiftUI

//View with weather details(weather icon and temperature) based on coordinates coming from the Helsinki API
struct WeatherWithAPICoordinates: View {
    
    let data: ProductResponse.Product
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        HStack {
            if let icon = URL(string: viewModel.icon) {
                AsyncImage(url: icon) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 35, maxHeight: 35)
                        .saturation(0.3)
                        .contrast(0.5)
                    
                } placeholder: {
                    ProgressView()
                }} else {
                }
            
            Text("\(Int(viewModel.temperature))°C")
                .font(Font.custom("Poppins-Regular", size: 12))
        }
        
        .onAppear {
            
            let trimmedCoordinates = data.postalAddresses?[0].location?
                .trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
            
            let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
            
            let lat: Double = Double(coordinateComponents[0]) ?? 0.0
            let long: Double = Double(coordinateComponents[1]) ?? 0.0
            
            let location = Location(latitude: lat, longitude: long)
            
            viewModel.fetchWeatherData(location: location)
            
        }
    }
}


//Code for the weather details with added popover view that includes (minTemp., maxTemp, humidity and wind)
struct ShowPopover: View {
    let data: ProductResponse.Product
    @StateObject var viewModel = WeatherViewModel()
    @State private var showingPopover = false
    
    var body: some View {
        
        //The small card with icon and temperature
        Button {
            showingPopover = true
        } label: {
            HStack {
                AsyncImage(url: URL(string: viewModel.icon), content: { image in image
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .frame(width: 30, height: 30)
                }, placeholder: {
                    ProgressView()
                })
                
                Text(viewModel.temperature.roundDouble() + "°C")
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.leading,4)
            .padding(.trailing, 12)
            .background(Color("ThemeColour") .cornerRadius(10) .shadow(radius: 5, x: 3, y: 0))
        }
        
        //The card for the detailed view with min and max temp, wind and humidity
        .popover(isPresented: $showingPopover) {
            VStack {
                VStack(spacing: 5) {
                    Text(data.postalAddresses?[0].streetName ?? "")
                        .font(.largeTitle)
                    Text(data.postalAddresses?[0].city ?? "")
                        .font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    HStack {
                        AsyncImage(url: URL(string: viewModel.icon), content: { image in image
                                .resizable()
                                .aspectRatio(contentMode:.fit)
                                .frame(maxWidth: 150, maxHeight: 150)
                        }, placeholder: {
                            ProgressView()
                        })
                        VStack {
                            Text(viewModel.temperature.roundDouble() + "°C")
                                .font(.system(size: 70))
                            Text("Feels like " + viewModel.feelsLike.roundDouble() + "°C")
                        }
                        .frame(width:150)
                        
                        
                    }
                    VStack {
                        HStack {
                            Spacer()
                            WeatherItem(logo: "thermometer", name: "Min temp", value: (viewModel.minTemperature.roundDouble() + "°C"))
                            Spacer()
                            WeatherItem(logo: "thermometer", name: "Max temp", value: (viewModel.maxTemperature.roundDouble() + "°C"))
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            WeatherItem(logo: "wind", name: "Wind", value: (viewModel.windSpeed.roundDouble() + "m/s"))
                            Spacer()
                            WeatherItem(logo: "humidity", name: "Humidity", value: (viewModel.humidity.roundDouble() + "%"))
                            Spacer()
                        }
                    }.padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundBlurView())
                Spacer()
            }
            .ignoresSafeArea()
        }
        .onAppear {
            
            let trimmedCoordinates = data.postalAddresses?[0].location?
                .trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
            
            let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
            
            let lat: Double = Double(coordinateComponents[0]) ?? 0.0
            let long: Double = Double(coordinateComponents[1]) ?? 0.0
            
            let location = Location(latitude: lat, longitude: long)
            viewModel.fetchWeatherData(location: location)
        }
    }
}


struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

