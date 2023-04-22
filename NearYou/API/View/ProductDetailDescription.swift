//
//  ProductDetailDescription.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI

struct ProductDetailDescription: View {
    
    //let data: ProductResponse.Product
    
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
                        Text("Title of Product")
                            .bold()
                        .padding(.bottom)
                        Spacer()
                        Text("Address of product")
                            .padding(.bottom)
                    }
                    
                    
                    
                    Text("UNITY. For tomorrow's professionals. \n\nModern studio apartments and workspaces for efficient work and better life. Stay for a day, a month, or a year.")
                        .padding(.leading)
                    
                    Text("Product Availability")
                        .padding(.top)
                        .padding(.bottom)
                    
                    HStack{
                        VStack(alignment: .leading){
                            Text("Opening Days")
                                .padding(.bottom)
                            Text("Sun: 09:00 - 10:00")
                            Text("Mon: 09:00 - 10:00")
                            Text("Tue: 09:00 - 10:00")
                            Text("Wed: 09:00 - 10:00")
                            Text("Thu: 09:00 - 10:00")
                            Text("Fri: 09:00 - 10:00")
                            Text("Sat: 09:00 - 10:00")
                        }
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Opening Month")
                                .padding(.bottom)
                            Text("Jan")
                            Text("Feb")
                            Text("Mar")
                            Text("Apr")
                            Text("May")
                            Text("June")
                            Text("July")
                        }
                    }
                    
                    Text("Product Price: 10 euros per hour")
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


struct ProductDetailDescription_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailDescription()
    }
}
