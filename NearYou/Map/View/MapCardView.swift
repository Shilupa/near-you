//
//  MapCardView.swift
//  NearYou
//
//  Created by iosdev on 16.4.2023.
//

import SwiftUI
import CoreLocation

struct MapCardView: View {
    let data: ProductResponse.Product

    var body: some View {
        VStack {
            let trimmedCoordinates = data.postalAddresses?[0]
                .location?
                .trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
            
            let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
            let coordinate = CLLocationCoordinate2D(latitude: Double(coordinateComponents[0]) ?? 0.0, longitude: Double(coordinateComponents[1]) ?? 0.0)
            Text("Latitude: \(coordinate.latitude)")
            Text("Longtitude: \(coordinate.longitude)")
        }
        .frame(width: 300, height: 100, alignment: .center)
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
    }
}
