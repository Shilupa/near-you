//
//  DemoView.swift
//  NearYou
//
//  Created by iosdev on 16.4.2023.
//
import SwiftUI
import CoreLocation
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    var location: MapMarker
}


//struct DemoView: View {
//
//    @StateObject var vm = DataViewModel()
//
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 64.1580144972565, longitude: 19.9126525486217), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//
//
//
//
//    var body: some View {
//        ZStack{
//
//
//            let markers = getMarkers()
//
//
//            Map(coordinateRegion: $region, showsUserLocation: true,
//                annotationItems: markers) { marker in
//                marker.location
//            }.edgesIgnoringSafeArea(.all)
//
//
//
//        }
//        .onAppear(perform:{
//            vm.getData()
//            }
//        )
//    }
//}


