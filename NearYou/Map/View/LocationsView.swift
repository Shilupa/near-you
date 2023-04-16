//
//  LocationsView.swift
//  NearYou
//
//  Created by iosdev on 15.4.2023.
//

import SwiftUI
import MapKit

struct LocationsView: UIViewRepresentable {
    
    @EnvironmentObject var mapData : LocationsViewModel
    // @StateObject var vm = DataViewModel()
    // let data : ProductResponse
    // let currentData : ProductResponse.Product

    
    func makeCoordinator() -> Coordinator {
        return LocationsView.Coordinator()
        
    }
    
    func makeUIView(context: Context) ->  MKMapView {
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
    }
}
