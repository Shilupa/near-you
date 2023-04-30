//
//  MapView.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI
import CoreLocationUI
import MapKit

/*
 MapView is used to display map in the Home View
 */
struct MapView: View {
    
    @EnvironmentObject  var viewModel : MapViewModel
    @State var searchText = ""
    @State private var currentIndex = 0
    @EnvironmentObject var vm: DataViewModel
    @State private var isSelected = false
    @State private var preview = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            if vm.isRefreshing {
                ProgressView()
            } else {
                let markers = getMarkers()
                //let _ = print("Markers", markers)
                let _ = print("UserLocation", viewModel.locationManager.location as Any)
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                    annotationItems: markers
                    // Array(markers.shuffled().prefix(5)))
                ) { marker in
                    marker.location
                }
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
                VStack{
                    Spacer()
                    
                    Button(action: {
                        preview.toggle()
                    }) {
                        Image(systemName: "scope")
                            .foregroundColor(.white)
                            .symbolVariant(.fill)
                            .font(Font.system(size: 24, weight: .bold))
                            .frame(width: 40, height: 40)
                            .background(Color("ThemeColour"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
        
                    if preview {
                        productsCardView
                            .transition(.move(edge: .trailing))
                            .animation(.default)

                    }
                    
                    HStack{
                        CustomSearchBar(searchText: $searchText)
                        currentUserLocationButton
                            .shadow(color:.gray,radius: 10)

                    }
                    .padding()
                }
            }
        }
    }
}

extension MapView {
    //button to recenter the map to user's location
    private var currentUserLocationButton : some View {
        Button(action: {
            viewModel.requestAllowOnceLocationPermission()
        }) {
            Image(systemName: "scope")
                .foregroundColor(.white)
                .symbolVariant(.fill)
                .font(Font.system(size: 24, weight: .bold))
                .frame(width: 40, height: 40)
                .background(Color("ThemeColour"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .foregroundColor(.white)
        .cornerRadius(8)
        .labelStyle(.iconOnly)
        .tint(Color("ThemeColour"))
        .symbolVariant(.fill)
        
    }
    
    //products card view diplayed on the map
    private var productsCardView : some View {
        Group {
            if let products = vm.allData?.data.product {
                NavigationLink(destination: DetailProductView(data: products[currentIndex])){
                    ProductCardHomeView(data: products[currentIndex])
                        .padding(.horizontal)
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
                                        let trimmedCoordinates = products[currentIndex].postalAddresses?[0]
                                            .location?
                                            .trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
                                        
                                        let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
                                        let coordinate = CLLocationCoordinate2D(latitude: Double(coordinateComponents[0]) ?? 0.0, longitude: Double(coordinateComponents[1]) ?? 0.0)
                                        viewModel.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
                                    }
                                }
                        )
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Text("Products loading...")
            }
        }
    }
}
