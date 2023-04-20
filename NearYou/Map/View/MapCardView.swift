//
//  MapCardView.swift
//  NearYou
//
//  Created by iosdev on 16.4.2023.
//

import SwiftUI
import CoreLocation

struct MapCardView: View {
    let data: ProductResponse.Product
    @State private var isSelected = false
    @EnvironmentObject  var viewModel : MapViewModel
    
    
    var body: some View {
        VStack(alignment: .leading){
            let url = URL(string:data.productImages?[0].thumbnailUrl ?? "http://placekitten.com/g/200/300" )
            
            
//            Text("Latitude: \(coordinate.latitude)")
//            Text("Longtitude: \(coordinate.longitude)")
            HStack{
                AsyncImage(url: url) { Image in
                    Image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 100)
                        .cornerRadius(10)
                } placeholder: {
                    
                    ProgressView()
                        .frame(width: 120, height: 100)
                }
                
                VStack(alignment: .leading){
                    Text(data.productInformations[0].name ?? "")
                        .font(Font.custom("Poppins-Regular", size: 12))

                
                    Text(data.postalAddresses![0].streetName ?? "")
                        .font(Font.custom("Poppins-Regular", size: 12))
                    Text(data.postalAddresses![0].city ?? "")
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
                .frame(width: 200, height: 100)
            }
            
        }
        .frame(width: 330, height: 100, alignment: .center)
        .padding(10)
        .background(isSelected ? Color.blue : Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
        .gesture(
            TapGesture()
                .onEnded {
                    isSelected.toggle()
                    
                    if (isSelected) {
                        let trimmedCoordinates = data.postalAddresses?[0]
                            .location?
                            .trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
                        
                        let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
                        let coordinate = CLLocationCoordinate2D(latitude: Double(coordinateComponents[0]) ?? 0.0, longitude: Double(coordinateComponents[1]) ?? 0.0)
                        viewModel.selectedLocation = coordinate
                        viewModel.updateRegion(for: viewModel.selectedLocation ?? CLLocationCoordinate2D(latitude: 30.158014,longitude: 24.912653) )
                        
                        print("from mapcardview: ", viewModel.selectedLocation ?? "")
                        print("from mapcardview: ", viewModel.region )
                        

                    }
                }
        )
    }
}
