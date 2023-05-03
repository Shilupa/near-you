//
//  DirectionsMapView.swift
//  NearYou
//
//  Created by Bibek on 24.4.2023.
//

import SwiftUI
import CoreLocation
import MapKit

/*
 MapView being used for DirectionsView
 */
struct DirectionsMapView : UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    let destination: CLLocationCoordinate2D
    var transportType : MKDirectionsTransportType
    
    @Binding var directions : [String]
    @Binding var distanceToDestination : Double?
    @Binding var estimatedTravelTime: TimeInterval?
    
    @ObservedObject var locationManager = DirectionsLocationManager()
    
    func makeCoordinator() -> DirectionsMapViewCoordinator {
        return DirectionsMapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // setting map region to destination's coordinates
        let region = MKCoordinateRegion(center: destination, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        let destinationPlaceMark = MKPlacemark(coordinate: destination)
        
        //requesting for directions between user's location and destination using Mapkit
        if let userLocation = mapView.userLocation.location {
            let startPlacemark = MKPlacemark(coordinate: userLocation.coordinate)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: startPlacemark)
            request.destination = MKMapItem(placemark: destinationPlaceMark)
            request.transportType = transportType
            
            let directions = MKDirections(request: request)
            directions.calculate{ response, error in
                guard let route = response?.routes.first else {return}
                mapView.addAnnotation(destinationPlaceMark)
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                                          animated: true)
                
                //routes direction to reach the destination
                self.directions = route.steps.map {$0.instructions}.filter{!$0.isEmpty}
                
                // calculating distance between user location and the destination
                let distanceInMeters = userLocation.distance(from: CLLocation(latitude: destination.latitude, longitude: destination.longitude))
                let distanceInKm = distanceInMeters / 1000
                self.distanceToDestination = round(distanceInKm * 100) / 100
                
                // calculating the estimated travel time
                self.estimatedTravelTime = round((route.expectedTravelTime/3600)*100)/100
            }   
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context){
    }
    
    
    class DirectionsMapViewCoordinator : NSObject, MKMapViewDelegate {
        
        //function to generate a line to visually display the distance between two coordinates
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor(named: "ThemeColour")
            renderer.lineWidth = 5
            
            return renderer
        }
        
        // function to generate each annotation on the map
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            } else {
                let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                annotationView.pinTintColor = .red
                annotationView.animatesDrop = true
                return annotationView
            }
        }
        
        //function to calculate distance between two coordinates
        func distance(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) -> CLLocationDistance {
            let sourceLocation = CLLocation(latitude: source.latitude, longitude: source.longitude)
            let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
            return sourceLocation.distance(from: destinationLocation)
        }
        
    }
}
