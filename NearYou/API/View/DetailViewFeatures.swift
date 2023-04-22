//
//  DetailViewFeatures.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 23.4.2023.
//

import SwiftUI

struct DetailViewFeatures: View {
    
    let options = ["Option 1", "Option 2", "Option 3"]
    @State private var selectedOption = "Option 1"
    @State private var isFavourite = false
    
    
    var body: some View {
        
        HStack{
            
            
            Picker("Options", selection: $selectedOption) {
                ForEach(options, id: \.self) {
                    Text($0)
                }}
                
            
            
            Button {
                
            } label: {
                Text("Plan Trip")
                    .padding()
            }.background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(Color.white)

            
            Toggle(isOn: $isFavourite) {
                Image(systemName: isFavourite ? "heart.fill" : "heart")
                    .resizable()
                    .foregroundColor(isFavourite ? .red : .gray)
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            
        }
        
        
        
    }
}

struct DetailViewFeatures_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewFeatures()
    }
}
