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
    
    @EnvironmentObject  var viewModel : MapViewModel
    @State var searchText = ""
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
                        NavigationLink(destination: DetailProductView(data: products[currentIndex])){
                            MapCardView(data: products[currentIndex])
                                .background(isSelected ? Color("ThemeColour") : Color.white)
                                .cornerRadius(10)
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
                        .accentColor(.black)
                    } else {
                        Text("Products loading...")
                    }
                
                    
                    HStack{
                        
                        CustomSearchBar(searchText: $searchText)
                        
                        Button(action: {
                            viewModel.requestAllowOnceLocationPermission()
                        }) {
                            Image(systemName: "scope")
                                .foregroundColor(.white)
                                .symbolVariant(.fill)
                                .font(Font.system(size: 24, weight: .bold))
                                .frame(width: 40, height: 40)
                                .background(Color.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .labelStyle(.iconOnly)
                        .tint(Color("ThemeColour"))
                        .symbolVariant(.fill)
                        
                    }
                    .padding()
                }
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
