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
                    Text("Loading...")
                }
            Text("\(Int(viewModel.temperature))°C")
                .font(.system(size: 12))
//            Text(data.postalAddresses![0].streetName ?? "")
//            .font(Font.custom("Poppins-Regular", size: 12))
            
        }
        
        .onAppear {
            print(data.location)
//            viewModel.fetchWeatherData(latitude: 45.753836, longitude: 21.225747)
            
            
        }
    }
}

struct WeatherWithAPICoordinates_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWithAPICoordinates()
    }
}
