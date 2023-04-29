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
            
            HStack{
                Text("Description")
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .bold()
                .padding(.leading)
                
                Spacer()
                
                Text("Language Picker")
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
                            
                            ShowPopover(data: data)
                        }
                        .font(Font.custom("Poppins-Regular", size: 14))
                            .frame(width: 150, height: 20)
                    }.padding(.top)

                    
                    Text(data.productInformations[0].description ?? "")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        
                        

                    if data.accessible != nil {
                        HStack{
                            Text("Accessibility: ")
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .padding(.top)
                                .padding(.bottom)
                            Text("Yes")
                                .bold()
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color(.systemGreen))
                        }
                        
                    }else{
                        HStack{
                            Text("Accessibility: ")
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .padding(.top)
                                .padding(.bottom)
                            Text("No")
                                .bold()
                                .font(Font.custom("Poppins-Regular", size: 16))
                                .foregroundColor(Color(.red))
                        }
                    }
                    
                    
                    
                    HStack(alignment: .top){
                        VStack(alignment: .leading){


                            Text("Opening Days")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .bold()

                            ForEach(data.businessHours.businessHoursDefault, id: \.self){ item in
                                HStack {
                                    Text(item.weekday?.capitalized.prefix(3) ?? "")
                                    Text(": ")
                                    Text(item.opens?.prefix(5) ?? "")
                                    Text("-")
                                    Text(item.closes?.prefix(5) ?? "")
                                }.font(Font.custom("Poppins-Regular", size: 14))
                            }

                        }
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Opening Months")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .bold()
                            VStack(alignment: .leading) {
                                ForEach(data.productAvailableMonths ?? [], id: \.self){ month in
                                    Text(month.month?.capitalized ?? "")
                                        .font(Font.custom("Poppins-Regular", size: 14))
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
                            Text("euros/" + unit)
                            //Text(unit)
                        }.font(Font.custom("Poppins-Regular", size: 16))
                        .padding(.top)
                            .padding(.bottom)
                    }
                }
            }.padding(10)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .background(Color("CardBackground"))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                .shadow(color: Color("ThemeColour").opacity(0.1), radius: 5)
        }
        .padding()
    }
}

//struct ProductDetailDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailDescription()
//    }
//}
