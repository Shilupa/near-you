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
                
                if (selectedTransportType == TransportType.walking) {
                    DirectionsMapView(destination: destination,
                                      transportType: selectedTransportType.mkDirectionsTransportType,
                                      directions: $directions,
                                      distanceToDestination: $distanceToDestination,
                                      estimatedTravelTime: $estimatedTravelTime
                    )
                }else {
                    DirectionsMapView(destination: destination,
                                      transportType: TransportType.driving.mkDirectionsTransportType,
                                      directions: $directions,
                                      distanceToDestination: $distanceToDestination,
                                      estimatedTravelTime: $estimatedTravelTime
                    )
                }
                
                
                
                HStack {
                    
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
            
            Button(action: {
                self.showDirections.toggle()
            }, label: {
                Text("Show Directions")
            })
            .disabled(directions.isEmpty)
            .padding()
        }
        .sheet(isPresented: $showDirections, content: {
            VStack{
                Text("Directions")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Distance To Destination: " + String(distanceToDestination ?? 0.0) + "km")
                    .bold()
                
                Text("Etimated Travel Time: " + String(estimatedTravelTime ?? 0.0) + "hrs")
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
