//
//  MapViewModel.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI
import CoreLocationUI
import MapKit

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion()
    
    // alert when permission is denied
    @Published var permissionDenied = false
    
    @Published var selectedLocation : CLLocationCoordinate2D?
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestAllowOnceLocationPermission () {
        locationManager.requestLocation()
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
//    func updateRegion(for location: CLLocationCoordinate2D) {
//        let newRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//        self.region = newRegion
//        selectedLocation = location
//    }
}
