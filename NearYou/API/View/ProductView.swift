//
//  ProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import SwiftUI

struct ProductView: View {
    
    let data: ProductResponse.Product
    
    var body: some View {
        
        let url = URL(string:data.productImages?[0].thumbnailUrl ?? "http://placekitten.com/g/200/300" )
        
        HStack(alignment: .center) {
            
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
                    .lineLimit(1)
                    .font(.title3)
                
                Text(data.postalAddresses![0].streetName ?? "")
                    .font(.caption)
                
                Text(data.postalAddresses![0].city ?? "")
                    .font(.caption)
                
                Text(data.productImages?[0].altText ?? "")
                    .lineLimit(1)
                    .font(.title3)
                
            }}
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding(5)
        .shadow(radius: 10)
        .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        
        
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
        //        ProductView(data: .init(id: 0,
        //                             email: "tunds@gmail",
        //                             name: "Tunde Adegoroye",
        //                             company: .init(name: "tundsdev")))
    }
}
