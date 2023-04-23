//
//  DirectionView.swift
//  NearYou
//
//  Created by iosdev on 23.4.2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct DirectionsView: View {
    
    let destination: CLLocationCoordinate2D
    
    init(destination: CLLocationCoordinate2D) {
        self.destination = destination
    }
    
    @State private var directions : [String] = []
    @State private var showDirections = false
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack{
            DirectionsMapView(destination: destination, directions: $directions)
            Button(action: {
                self.showDirections.toggle()
            }, label: {
                Text("Show Directions")
            })
            .disabled(directions.isEmpty)
            .padding()
            //            Text(String(format: "Lat: %.2f, Long: %.2f", destination.latitude, destination.longitude))
        }
        .sheet(isPresented: $showDirections, content: {
            VStack{
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                                
                List {
                    ForEach(0..<self.directions.count, id: \.self) { i in
                        Text(self.directions[i])
                            .padding()
                    }
                }
                
            }
        })
        
    }
}

class DirectionsLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        self.location = userLocation.coordinate
    }
}

struct DirectionsMapView : UIViewRepresentable {
        
    typealias UIViewType = MKMapView
    let destination: CLLocationCoordinate2D
    
    @Binding var directions : [String]
    
    @ObservedObject var locationManager = DirectionsLocationManager()

    
    func makeCoordinator() -> DirectionsMapViewCoordinator {
        return DirectionsMapViewCoordinator()
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: destination, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        print("userlocation", mapView.userLocation)
        
        let destinationPlaceMark = MKPlacemark(coordinate: destination)
//        let startPlaceMark = MKPlacemark(coordinate
//                                         : CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))
        
        if let userLocation = mapView.userLocation.location {
            let startPlacemark = MKPlacemark(coordinate: userLocation.coordinate)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: startPlacemark) // Use startPlacemark instead of startPlaceMark
            request.destination = MKMapItem(placemark: destinationPlaceMark)
            request.transportType = .walking
            
            let directions = MKDirections(request: request)
            directions.calculate{ response, error in
                guard let route = response?.routes.first else {return}
                mapView.addAnnotations([destinationPlaceMark])
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                                          animated: true)
                
                self.directions = route.steps.map {$0.instructions}.filter{!$0.isEmpty}
        }
        
        
        }
        return mapView
  
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    class DirectionsMapViewCoordinator : NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5
            
            return renderer
        }
    }
}

