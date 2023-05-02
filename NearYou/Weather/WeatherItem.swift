//
//  WeatherItem.swift
//  WeatherIconApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI

//Used for detailed weather view
struct WeatherItem: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        VStack {
            Image(systemName: logo)
                .font(.title2)
                .padding(.bottom, 5)
            Text(name)
                .font(.caption)
            Text(value)
                .bold()
                .font(.title2)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.horizontal, 10)
        .background(Color.gray.opacity(0.2).cornerRadius(10).shadow(radius: 10))
    }
}

struct WeatherItem_Previews: PreviewProvider {
    static var previews: some View {
        WeatherItem(logo: "thermometer", name: "Feels like", value: "8")
    }
}
