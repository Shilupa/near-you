//
//  MapView.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    @State var searchText = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
            
            HStack{
                
                CustomSearchBar(searchText: $searchText)
                
                LocationButton(.currentLocation){
                    viewModel.requestAllowOnceLocationPermission()
                }
                .foregroundColor(.white)
                .cornerRadius(8)
                .labelStyle(.iconOnly)
                .tint(.orange)
                .symbolVariant(.fill)

            }
            .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
