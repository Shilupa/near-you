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
    @State private var showAlert = false
    @State var isPresented = false
    
    var body: some View {
        
        HStack{
            
            Button {
                if(isPlanned){
                    pvm.deletePlanned(id)
                    isPlanned = false
                    self.showAlert = true
                }else{
                    isPlanned = true
                    pvm.addplanned(id)
                    self.showAlert = true
                }
            } label: {
                Text("Plan Trip")
                    .padding()
            }.background(isPlanned ? Color.gray: Color.blue)
                .cornerRadius(10)
                .foregroundColor(Color.white)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: isPlanned ? Text("Product added to Planned List \u{1F601}") : Text("Product removed from Planned List \u{1F614}"), dismissButton: .default(Text("OK")))
                }
            
            
            Button {
                isPresented = true
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
                        isFavourite.toggle()
                    }else{
                        fvm.deleteFavourite(id)
                        isFavourite.toggle()
                    }
                }
        }.fullScreenCover(isPresented: $isPresented){
            NavigationView {
                UploadPhotosView(id: $id)
                    .navigationTitle("Upload Photos")
                    .navigationBarItems(
                        leading: Button("Back") {
                            isPresented = false
                        }
                    )
            }
        }
    }
}

//struct DetailViewFeatures_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewFeatures()
//    }
//}
