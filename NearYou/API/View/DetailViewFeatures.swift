//
//  DetailViewFeatures.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 23.4.2023.
//

import SwiftUI

struct DetailViewFeatures: View {
    @StateObject private var fvm = FavouritesViewModel()
    @StateObject private var pvm = PlannedViewModel()
    @StateObject private var vvm = VisitedViewModel()
    @StateObject private var pivm = PlaceImageViewModel()
    
    @Binding var isFavourite: Bool
    @Binding var id: String
    @Binding var isPlanned: Bool
    @Binding var isVisited: Bool
    @State private var showPlannedAlert = false
    @State private var showVisitedAlert = false
    @State var isPresented = false
    @State var imageList = [Data]()
    
    var body: some View {
        VStack{
            // Displays user added photos in detail view: Needs styling 
            ForEach(pivm.savedSetting.filter({ $0.placeId == id }), id: \.self) { image in
                let placeImage = UIImage(data: image.placeImage ?? Data()) ?? UIImage(named: "profile")!
                Image(uiImage: placeImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            HStack{
                Button {
                    if(isPlanned){
                        pvm.deletePlanned(id)
                        isPlanned = false
                        self.showPlannedAlert = true
                    }else{
                        isPlanned = true
                        pvm.addplanned(id)
                        self.showPlannedAlert = true
                    }
                } label: {
                    Text("Plan Trip")
                        .padding()
                }.background(isPlanned ? Color.blue: Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .alert(isPresented: $showPlannedAlert) {
                        Alert(title: Text("Alert"), message: isPlanned ? Text("Product added to Planned List \u{1F601}") : Text("Product removed from Planned List \u{1F614}"), dismissButton: .default(Text("OK")))
                    }
                Button {
                    if(isVisited){
                        isVisited = false
                        // Removes visited place by id from Core Data
                        vvm.deleteVisited(id)
                        self.showVisitedAlert = true
                        // Removes images with same id from CoreData
                        for _ in 0..<pivm.savedSetting.count{
                            pivm.deletePlaceImage(id)
                        }
                    }else{
                        isVisited = true
                        // Adds visited place to CoreData with place id
                        vvm.addPlace(id)
                        self.showVisitedAlert = true
                    }
                } label: {
                    Text("Visited")
                        .padding()
                }.background(isVisited ? Color.blue: Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .alert(isPresented: $showVisitedAlert) {
                        Alert(title: Text("Alert"), message: isVisited ? Text("Product added to Visited List \u{1F601}") : Text("Product removed from Visited List \u{1F614}"), dismissButton: .default(Text("OK")))
                    }
                // button sample to add photo for visited place
                if(isVisited){
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Text("Add Memo")
                    })
                }
                
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
            }
            .fullScreenCover(isPresented: $isPresented){
                NavigationView {
                    UploadPhotosView(id: $id)
                        .navigationTitle("Upload Photos")
                        .navigationBarItems(
                            leading: Button("Back") {
                                isPresented = false
                                pivm.fetchSettings()
                            }
                        )
                }
            }
        }
    }
}

//struct DetailViewFeatures_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewFeatures()
//    }
//}
