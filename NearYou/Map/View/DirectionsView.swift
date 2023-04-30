//
//  DirectionView.swift
//  NearYou
//
//  Created by Bibek on 23.4.2023.
//

import SwiftUI
import CoreLocation
import MapKit

/*
 DirectionsView presents users with a map view where user can see their location and the selected destination.
 The distance between them is presented using a line
 */
struct DirectionsView: View {
    
    let destination: CLLocationCoordinate2D
    init(destination: CLLocationCoordinate2D) {
        self.destination = destination
    }
    
    @State private var directions : [String] = []
    @State private var distanceToDestination : Double?
    @State private var showDirections = false
    @State private var estimatedTravelTime : TimeInterval?
    @State private var selectedTransportType = TransportType.walking
    @StateObject private var locationManager = LocationManager()
    
    enum TransportType: String, CaseIterable {
        case walking
        case driving
        
        var title: String {
            switch self {
            case .walking:
                return "Walking"
            case .driving:
                return "Driving"
                
            }
        }
        
        var mkDirectionsTransportType: MKDirectionsTransportType {
            switch self {
            case .walking:
                return .walking
            case .driving:
                return .automobile
                
            }
        }
    }
    
    var body: some View {
        VStack{
            ZStack (alignment: .topLeading) {
                DirectionsMapViewSection
                transportPickerSection
            }
            showDirectionButton
        }
        .sheet(isPresented: $showDirections, content: {
            directionSheets
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

extension DirectionsView {
    
    private var DirectionsMapViewSection : some View {
        VStack{
        //conditional rendering of DirectionsMapView when toggling between cycling or driving
        if (selectedTransportType == TransportType.walking) {
            DirectionsMapView(destination: destination,
                              transportType: selectedTransportType.mkDirectionsTransportType,
                              directions: $directions,
                              distanceToDestination: $distanceToDestination,
                              estimatedTravelTime: $estimatedTravelTime
            )
        }else {
            DirectionsMapView(destination: destination,
                              transportType: selectedTransportType.mkDirectionsTransportType,
                              directions: $directions,
                              distanceToDestination: $distanceToDestination,
                              estimatedTravelTime: $estimatedTravelTime
            )
        }
        }
    }
    
    private var transportPickerSection : some View {
        HStack() {
            Spacer()
            
            Picker(selection: $selectedTransportType, label: Text("Transport Type")) {
                ForEach(TransportType.allCases, id: \.self) { transportType in
                    Text(transportType.title).tag(transportType)
                }
            }
            .frame(width: 200)
            .background(Color.white.cornerRadius(10))
            .foregroundColor(.blue)
            .padding()
            .cornerRadius(20)
            .font(.headline)
            .pickerStyle(SegmentedPickerStyle())
            
            Spacer()
        }
    }
    
    private var showDirectionButton : some View {
        Button(action: {
            self.showDirections.toggle()
        }, label: {
            Text("Show Directions")
        })
        .disabled(directions.isEmpty)
        .padding()
    }
    
    private var directionSheets : some View {
        VStack{
            Text("Directions")
                .font(.largeTitle)
                .bold()
                .padding()
            // displaying distance between user and the destination
            Text("Distance To Destination: " + String(distanceToDestination ?? 0.0) + "km")
                .bold()
            // displaying estimated travel time
            Text("Etimated Travel Time: " + String(estimatedTravelTime ?? 0.0) + "hrs")
                .bold()
                .padding()
            // list of each step of the directions between the user and the destination
            List {
                ForEach(0..<self.directions.count, id: \.self) { i in
                    Text(self.directions[i])
                        .padding()
                }
            }
            
        }
    }
}
