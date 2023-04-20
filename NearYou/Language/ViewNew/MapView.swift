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
    
    //    @StateObject var viewModel = MapViewModel()
    @EnvironmentObject  var viewModel : MapViewModel
    
    @StateObject private var viewModel = MapViewModel()
    @State var searchText = ""
    //@StateObject var vm = DataViewModel()
    @State private var currentIndex = 0
    @EnvironmentObject var vm: DataViewModel
    @State private var isSelected = false
    
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
                            .environmentObject(MapViewModel())
                            .gesture(
                                DragGesture(minimumDistance: 20)
                                    .onEnded { value in
                                        withAnimation(.spring())
                                        {
                                            if value.translation.width > 0 {
                                                currentIndex = max(currentIndex - 1, 0)
                                            } else {
                                                currentIndex = min(currentIndex + 1, products.count - 1)
                                            }
                                        }
                                    }
                                
                            )
                            .gesture(
                                TapGesture()
                                    .onEnded {
                                        withAnimation(.easeInOut(duration: 1.0)){
                                            let trimmedCoordinates = products[currentIndex].postalAddresses?[0]
                                                .location?
                                                .trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
                                            
                                            let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
                                            let coordinate = CLLocationCoordinate2D(latitude: Double(coordinateComponents[0]) ?? 0.0, longitude: Double(coordinateComponents[1]) ?? 0.0)
                                            viewModel.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                                        }
                                    }
                            )
                    } else {
                        Text("No products found.")
                    }
                    
                    HStack{
                        
                        CustomSearchBar(searchText: $searchText)
                        
                        LocationButton(.shareMyCurrentLocation){
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

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
