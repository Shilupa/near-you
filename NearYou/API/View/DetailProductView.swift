//
//  DetailProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 15.4.2023.
//

import SwiftUI

struct DetailProductView: View {
    
    let data: ProductResponse.Product
    
    var body: some View {
        
        VStack(alignment: .leading){
            ScrollView{
                
                
                PhotoGalaryView()
                
                
                
                Text("Date of updated information")
                
                
                DetailViewOptions()
                
                
                
                ProductDetailDescription()
                
                Group {
                    Text("Product Address")
                    
                    Text("Available months")
                    
                    Text("Product price")
                    
                    Text("product avaibility")
                    
                    Text("Accebility")
                    
                    Text("language selector")
                    
                    Text("Put in favourite")
                    
                    Text("Plan the trip")
                }
                
                
                DetailViewSocialMedia()
            }
            
            
            
            
        }
        
    }
}

//struct DetailProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProductView()
//    }
//}
