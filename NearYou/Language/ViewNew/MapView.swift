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
    
    @EnvironmentObject var vm: DataViewModel
    
    @StateObject private var viewModel = MapViewModel()
    @State var searchText = ""
    //@StateObject var vm = DataViewModel()
    @State private var currentIndex = 0
    
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            
            if vm.isRefreshing {
                ProgressView()
            } else {
                
                let markers = getMarkers()
                
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                    annotationItems: markers) { marker in
                    marker.location
                }
                    .ignoresSafeArea()
                    .accentColor(Color(.systemPink))
                VStack{
                    
                    Spacer()
                    
                    if let products = vm.allData?.data.product {
                        
                        
                        MapCardView(data: products[currentIndex])
                            .gesture(
                                DragGesture(minimumDistance: 20)
                                    .onEnded { value in
                                        if value.translation.width > 0 {
                                            currentIndex = max(currentIndex - 1, 0)
                                        } else {
                                            currentIndex = min(currentIndex + 1, products.count - 1)
                                        }
                                    }
                            )
                    } else {
                        Text("No products found.")
                    }
                    
                    
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
        //        .onAppear(perform:{
        //            vm.getData()
        //        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
