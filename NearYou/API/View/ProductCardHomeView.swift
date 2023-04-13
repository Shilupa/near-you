//
//  ProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import SwiftUI

struct ProductCardHomeView: View {
    
    let data: ProductResponse.Product
    
    var body: some View {

        
        
        let url = URL(string:data.productImages?[0].thumbnailUrl ?? "http://placekitten.com/g/200/300" )
        
        HStack {
            
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
                
                // Title of the product
                Text(data.productInformations[0].name ?? "")
                    .lineLimit(1)
                    .font(.title3)
                    .shadow(radius: 0.5)
                
                // Address of the product
                HStack{
                    Text(data.postalAddresses![0].streetName ?? "")
                        .font(.caption)
                    Text(data.postalAddresses![0].city ?? "")
                        .font(.caption)
                }
                
                
                // Opening Hours
                HStack{
                    Text("Opening Hours:")
                        .font(.caption)
                        .bold()
                    Text(data.postalAddresses![0].city ?? "")
                        .font(.caption)
                }
                
                
                
                Text(data.productImages?[0].altText ?? "")
                    .lineLimit(1)
                    .font(.title3)
                
            }}
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(5)
        .background(Color("CardBackground"))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
        .shadow(color: Color("ThemeColour").opacity(0.1), radius: 5)

    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello Product Card Home View ")
    }
}
