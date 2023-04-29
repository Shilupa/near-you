//
//  MapCardView.swift
//  NearYou
//
//  Created by iosdev on 16.4.2023.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapCardView: View {
    let data: ProductResponse.Product
    @State private var isSelected = false
    @EnvironmentObject  var viewModel : MapViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            let url = URL(string:data.productImages?[0].thumbnailUrl ?? "http://placekitten.com/g/200/300" )
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
                    Text(data.productInformations?[0].name ?? "")
                        .bold()
                        .lineLimit(1)
                        .font(Font.custom("Poppins-Regular", size: 12))
                    Text(data.postalAddresses![0].streetName ?? "")
                        .font(Font.custom("Poppins-Regular", size: 12))
                    Text(data.postalAddresses![0].city ?? "")
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
                .frame(width: 200, height: 100, alignment: .topLeading)
            }
        }
        .frame(width: 330, height: 100, alignment: .center)
        .padding(10)
    }
    
}
