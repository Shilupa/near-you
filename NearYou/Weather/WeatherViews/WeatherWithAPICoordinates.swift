//
//  WeatherWithAPICoordinates.swift
//  NearYou
//
//  Created by iosdev on 19.4.2023.
//

import SwiftUI

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
            
            //print("Hahaha: ", coordinateComponents)
            viewModel.fetchWeatherData(location: location)
            
        }
    }
}
//
//struct WeatherWithAPICoordinates_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherWithAPICoordinates()
//    }
//}
