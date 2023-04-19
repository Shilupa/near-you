//
//  ProductDetailDescription.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI

struct ProductDetailDescription: View {
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Description")
                .font(Font.custom("Poppins-Regular", size: 16))
                .bold()
                .padding(.leading)
            
            Text ("UNITY. For tomorrow's professionals. \n\nModern studio apartments and workspaces for efficient work and better life. Stay for a day, a month, or a year.")
                .padding(10)
                .foregroundColor(Color.black)
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .multilineTextAlignment(.leading)
                .background(Color(.lightGray).opacity(0.2))
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
        }
    }
}


struct ProductDetailDescription_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailDescription()
    }
}
