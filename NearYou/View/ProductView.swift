//
//  ProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import SwiftUI

struct ProductView: View {
    
    let data: SampleData 
    
    var body: some View {
        VStack(alignment: .leading) {
        Text("From Product View: \(data.id)" )
//            Text("**Name**: \(data.data.product.id)")
//            Text("**Email**: \(data.data.product.id)")
//            Divider()
//            Text("**Company**: \(data.data.product.id)")
//
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
        
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
