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
                ShowPopover(data: data)
            }
            
            Group {
                
                VStack (alignment: .leading){
                    HStack {
                        Text(data.productInformations[0].name ?? "")
                            .bold()
                            .font(Font.custom("Poppins-Regular", size: 16))
                        .padding(.bottom)
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text(data.postalAddresses?[0].streetName ?? "")
                            
                            HStack {
                                Text(data.postalAddresses?[0].city ?? "")
                                
                                Text(data.postalAddresses?[0].postalCode ?? "")
                            }
                            
                        }.font(Font.custom("Poppins-Regular", size: 14))
                            .frame(width: 150, height: 20)
                        
                    }
                    


                    Text(data.productInformations[0].description ?? "")
                        //.padding(.leading)

                    Text("Product Availability")
                        .bold()
                        .padding(.top)
                        .padding(.bottom)
                    
                    HStack(alignment: .top){
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
                        VStack(alignment: .leading){
                            Text("Opening Month")
                                .padding(.bottom)
                            VStack(alignment: .leading) {
                                ForEach(data.productAvailableMonths ?? [], id: \.self){ month in
                                    Text(month.month ?? "")
                                }
                            }
                        }
                    }
                    
                    
                    
                    if let unit: String = data.productPricings[0].pricingUnit{
                        HStack {
                            Text("Price: ")
                                .bold()
                            let startPrice:Double = data.productPricings[0].fromPrice ?? 0.0
                            Text(String(format: "%.1f", startPrice))
                            Text("-")
                            let endPrice:Double = data.productPricings[0].toPrice ?? 0.0
                            Text(String(format: "%.1f", endPrice))
                            Text(" per ")
                            Text(unit)
                        }.padding(.top)
                            .padding(.bottom)

                    }
                    
                    
                    
                    
                }
                
                
            }.padding(10)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .background(Color(.lightGray).opacity(0.2))
                .cornerRadius(20)
            
            
            
            
            
        }
        .padding()
    }
}


//struct ProductDetailDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailDescription()
//    }
//}
