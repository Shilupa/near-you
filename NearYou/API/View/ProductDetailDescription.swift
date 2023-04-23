//
//  ProductDetailDescription.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI

struct ProductDetailDescription: View {
    
    let data: ProductResponse.Product
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack {
                Text("Description")
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .bold()
                .padding(.leading)
                Spacer()
                Text("Weather")
            }
            
            Group {
                
                VStack (alignment: .leading){
                    HStack {
                        Text(data.productInformations[0].name ?? "")
                            .bold()
                        .padding(.bottom)
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text(data.postalAddresses?[0].streetName ?? "")
                            Text(data.postalAddresses?[0].city ?? "")
                            Text(data.postalAddresses?[0].postalCode ?? "")
                        }
                        
                    }
                    
                    
                    
                    Text(data.productInformations[0].description ?? "")
                        .padding(.leading)
                    
                    Text("Product Availability")
                        .bold()
                        .padding(.top)
                        .padding(.bottom)
                    
                    HStack{
                        VStack(alignment: .leading){
                            
                            
                            Text("Opening Days")
                                .padding(.bottom)
                            
                            ForEach(data.businessHours.businessHoursDefault, id: \.self){ item in
                                HStack {
                                    Text(item.weekday?.prefix(3) ?? "")
                                    Text(": ")
                                    Text(item.opens?.prefix(5) ?? "")
                                    Text("-")
                                    Text(item.closes?.prefix(5) ?? "")
                                }
                            }
                            
                        }
                        Spacer()
//                        VStack(alignment: .leading){
//                            Text("Opening Month")
//                                .padding(.bottom)
//
//                            let Hahaha = data.productAvailableMonths
//
//                            HStack {
//                                ForEach(Hahaha, id: \.self){ month in
//                                    Text(month.month ?? "")
//                                }
//                            }
//                        }
                    }
                    
                    Text("Price: 10 euros per hour")
                        .padding(.top)
                        .padding(.bottom)
                    
                    
                }
                
                
            }.padding(10)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .background(Color(.lightGray).opacity(0.2))
                .cornerRadius(20)
                //.shadow(color: Color.gray, radius: 7, x: 0, y: 2)
            
            
            
            
            
        }
    }
}


//struct ProductDetailDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailDescription()
//    }
//}
