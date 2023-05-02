//
//  LocationsViewModel.swift
//  NearYou
//
//  Created by iosdev on 15.4.2023.
//

import SwiftUI
import MapKit
import CoreLocation

class LocationsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // @ObservedObject private var vm = DataViewModel()
    
    @Published var mapView = MKMapView()
    
    // Region
    @Published  var region : MKCoordinateRegion!
    
    // alert when permission is denied
    @Published var permissionDenied = false
    
    // Map type
    @Published var mapType : MKMapType = .standard
    
    
    //updating maptype
    func updateMapType(){
        if mapType == .standard{
            mapType = .satellite
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // Focus Location
    
    func focusLocation(){
        guard let _ = region else {return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Permissions
        
        switch manager.authorizationStatus{
            
        case .notDetermined:
            // request user
            manager.requestWhenInUseAuthorization()
        case .restricted:
            ()
        case .denied:
            permissionDenied.toggle()
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        //Updating map
        self.mapView.setRegion(self.region, animated: true)
        
        //smooth
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        
    }
}
