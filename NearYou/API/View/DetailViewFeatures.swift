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
    @State private var showVisitedAlert = false
    @State var imageList = [Data]()
    
    var body: some View {
        VStack{
            
            VStack(alignment: .leading){
                Text("User features")
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .bold()
                    .padding(.bottom)
                    .padding(.leading)
                
                HStack{
                    Spacer()
                    planTripButton
                    Spacer()
                    visitedTripButton
                    Spacer()
                    favouriteIcon
                    Spacer()
                }
                
            }
            
            if(isVisited){
                Spacer(minLength: 20)
                
                VStack{
                    HStack{
                        
                        Text("Add your memories:")
                            .font(Font.custom("Poppins-Regular", size: 15))
                            .padding(.leading)
                        
                        Spacer()
                        
                        // button sample to add photo for visited place
                        Button(action: {
                            // isPresented = true
                            
                            
                        }, label: {
                            
                            
                            NavigationLink(destination: UploadPhotosView(id: $id)){
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.primary)
                                    .imageScale(.large)
                            }
                            .opacity(1.0)
                            .onAppear{
                                pivm.fetchSettings()
                            }
                            
                        })
                        .padding(.trailing,20)
                    }.padding(.top, 10)
                    
                    
                    
//                    .fullScreenCover(isPresented: $isPresented){
//                        NavigationView {
//                            UploadPhotosView(id: $id)
//                            //.navigationTitle("Upload Photos")
//                                .navigationBarItems(
//                                    leading: Button(action: {
//                                        isPresented = false
//                                        pivm.fetchSettings()
//                                    }) {
//                                        HStack {
//                                            Image(systemName: "chevron.left")
//                                                .foregroundColor(.blue)
//                                            Text("Back")
//                                        }
//                                    }
//                                )
//                        }
//                    }
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack{
                            // Displays user added photos in detail view: Needs styling
                            ForEach(pivm.savedSetting.filter({ $0.placeId == id }), id: \.self) { image in
                                let placeImage = UIImage(data: image.placeImage ?? Data()) ?? UIImage(named: "profile")!
                                Image(uiImage: placeImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .none, maxHeight: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding()
                            }
                        }
                        .frame(width: .none, height: .none)
                    }
                }
                .background(Color("CardBackground"))
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                .shadow(color: Color("ThemeColour").opacity(0.1), radius: 5)
                .padding()
                
            }
            
        }
    }
}


extension DetailViewFeatures{
    
    private var planTripButton: some View{
        Button {
            if(isPlanned){
                
                pvm.deletePlanned(id)
                isPlanned = false
            }else{
                isPlanned = true
                pvm.addplanned(id)
            }
        } label: {
            Text(isPlanned ? "Cancel Plan": "Plan Trip")
                .bold()
                .font(Font.custom("Poppins-Regular", size: 14))
                .frame(width: 120, height: 40)
            
        }.background(isPlanned ? Color("ThemeColour"): Color.gray)
            .cornerRadius(20)
            .foregroundColor(Color.white)
            .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
        
    }
    
    
    private var visitedTripButton: some View{
        Button {
           
            withAnimation(.spring()) {
                if(isVisited){
                    self.showVisitedAlert = true
                }else{
                    isVisited = true
                    // Adds visited place to CoreData with place id
                    vvm.addPlace(id)
                    // self.showVisitedAlert = true
                }
            }
            
            
            
            
            
        } label: {
            Text(isVisited ? "Remove Visited" : "Mark Visited")
                .bold()
                .font(Font.custom("Poppins-Regular", size: 14))
                .frame(width: 150, height: 40)
            
        }.background(isVisited ? Color("ThemeColour"): Color.gray)
            .cornerRadius(20)
            .foregroundColor(Color.white)
            .alert(isPresented: $showVisitedAlert) {
                Alert(title: Text(isVisited ?"Are you sure?": "Info"),
                      message: isVisited ? Text("Are you sure you want to remove this item from visited? \n- Your added memories pictures will be deleted."): Text("Product added to Visited List \u{1F601} \n- You can add your memories pictures to this item."),
                      primaryButton: .default(Text("Ok")){
                    
                    withAnimation(.spring()) {
                        // Removes visited place by id from Core Data
                        vvm.deleteVisited(id)
                        
                        // Removes images with same id from CoreData
                        for _ in 0..<pivm.savedSetting.count{
                            pivm.deletePlaceImage(id)
                        }
                        isVisited = false
                    }
                    
                    
                },
                      secondaryButton: .cancel())
            }
            .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
        
    }
    
    
    
    
    private var favouriteIcon: some View {
        Button(action: {
                if(!isFavourite){
                    fvm.addfavourite(id)
                    isFavourite.toggle()
                }else{
                    fvm.deleteFavourite(id)
                    isFavourite.toggle()
                }
                        
        }) {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .resizable()
                .foregroundColor(isFavourite ? .red : .gray)
                .frame(width: 30, height: 30)
                .scaleEffect(isFavourite ? 1.15 : 1)
        }
    }
}




//struct DetailViewFeatures_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewFeatures()
//    }
//}
