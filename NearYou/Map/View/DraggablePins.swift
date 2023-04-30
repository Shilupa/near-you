//
//  DraggablePins.swift
//  NearYou
//
//  Created by Bibek on 29.4.2023.
//

import SwiftUI
import MapKit

struct DraggablePins: View {
    var body: some View {
        DraggableMapView().ignoresSafeArea()
    }
}

struct DraggablePins_Previews: PreviewProvider {
    static var previews: some View {
        DraggablePins()
    }
}

struct DraggableMapView : UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return DraggableMapView.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<DraggableMapView>) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true // Add this line to show user location
        map.userTrackingMode = .follow // Add this line to track user location
        
        let coordinate = CLLocationCoordinate2D(latitude: 13.086, longitude: 80.2707)
        map.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        map.delegate = context.coordinator
        
        map.addAnnotation(annotation)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<DraggableMapView>) {
        
    }
    
    class Coordinator : NSObject, MKMapViewDelegate {
        var parent : DraggableMapView
        init(parent1 : DraggableMapView) {
            parent = parent1
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self){return nil}
            else{
                
                let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                pin.isDraggable = true
                pin.tintColor = .red
                pin.animatesDrop = true
                
                return pin
            }
        }
    }
}
