//
//  Test.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 16.4.2023.
//

import Foundation
import CoreLocation
import _MapKit_SwiftUI

let vm = DataViewModel()

func getMarkers() -> [Marker] {

    vm.getData()
    var latitudes :Array<Double> = []
    var longitudes :Array<Double> = []
    
    
    if let products = vm.allData?.data.product {
        for product in products {
            
            let trimmedCoordinates = product.postalAddresses?[0].location?
                .trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
            let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
            if coordinateComponents.count>1 {
                latitudes.append(Double(coordinateComponents[0]) ?? 0.0)
                longitudes.append(Double(coordinateComponents[1]) ?? 0.0)
            }
        }
    }
    
    let locations = zip(latitudes, longitudes).map { CLLocationCoordinate2D(latitude: $0.0, longitude: $0.1) }

    var markers = [Marker]()
    for location in locations {
        markers.append(Marker(location: MapMarker(coordinate: location, tint: .red)))
    }
    return markers
}





