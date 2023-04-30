//
//  DetailViewFeatures.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 23.4.2023.
//

import SwiftUI

struct DetailViewFeatures: View {
    
    
    @Binding var isFavourite: Bool
    @Binding var id: String
    @StateObject private var fvm = FavouritesViewModel()
    @StateObject private var pvm = PlannedViewModel()
    @Binding var isPlanned: Bool
    
    var body: some View {
        
        HStack{
            
            
            Button {
                if(isPlanned){
                    pvm.deletePlanned(id)
                    isPlanned = false
                }else{
                    isPlanned = true
                    pvm.addplanned(id)
                }
            } label: {
                Text("Plan Trip")
                    .padding()
            }.background(isPlanned ? Color.blue: Color.gray)
                .cornerRadius(10)
                .foregroundColor(Color.white)
            
            
            Button {
                
            } label: {
                Text("Visited")
                    .padding()
            }.background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(Color.white)

            
            

                Image(systemName: isFavourite ? "heart.fill" : "heart")
                    .resizable()
                    .foregroundColor(isFavourite ? .red : .gray)
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        if(!isFavourite){
                            fvm.addfavourite(id)
                        }else{
                            fvm.deleteFavourite(id)
                        }
            
            
//            Toggle(isOn: $isFavourite) {
//                Image(systemName: isFavourite ? "heart.fill" : "heart")
//                    .resizable()
//                    .foregroundColor(isFavourite ? .red : .gray)
//                    .scaledToFit()
//                    .frame(width: 30, height: 30)
//            }.onTapGesture {
//                if(!isFavourite){
//                    fvm.addfavourite(id)
//                }else{
//                    fvm.deleteFavourite(id)
//                }
            }
            
        }
    }
}

//struct DetailViewFeatures_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewFeatures()
//    }
//}
