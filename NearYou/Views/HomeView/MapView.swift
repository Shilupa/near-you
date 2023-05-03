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
    @State private var preview = true
    @State private var swipeLeft = true
    @State private var isSwipe = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            if vm.isRefreshing {
                ProgressView()
            } else {
                let markers = getMarkers()
                
                withAnimation(.spring()) {
                    Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                        annotationItems: markers
                    ) { marker in
                        marker.location
                    }
                    .ignoresSafeArea()
                    .accentColor(Color(.systemPink))
                }
                
                VStack{
                    Spacer()
                    
                    if preview {
                        productsCardView
                            .transition(.asymmetric(
                                insertion: .move(edge: swipeLeft ? .trailing : .leading),
                                removal: .scale(scale: 0.01)))
                            .onDisappear(perform: {
                                if isSwipe{
                                    preview.toggle()
                                    isSwipe.toggle()
                                }
                            })
                            .animation(.easeInOut(duration: 0.5))
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
                                            swipeLeft = false
                                            preview.toggle()
                                            isSwipe=true
                                        } else {
                                            currentIndex = min(currentIndex + 1, products.count - 1)
                                            swipeLeft = true
                                            preview.toggle()
                                            isSwipe=true
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
