//
//  VisitedPlaces.swift
//  NearYou
//
//  Created by Shilpa Singh on 1.5.2023.
//

import SwiftUI

struct VisitedPlacesView: View {
    @StateObject private var vvm = VisitedViewModel()
    @EnvironmentObject var vm: DataViewModel
    @StateObject private var pivm = PlaceImageViewModel()
    @State var plannedList = [ProductResponse.Product]()
    
    var body: some View {
        ZStack {
            //            List{
            //                ForEach(vvm.savedSetting, id: \.self) { place in
            //                    VStack(alignment: .leading){
            //                        ScrollView(.horizontal, showsIndicators: false) {
            //                            HStack(spacing: 10) {
            //                                ForEach(pivm.savedSetting.filter({ $0.placeId == place.placeId }), id: \.id) { image in
            //                                    let placeImage = UIImage(data: image.placeImage ?? Data()) ?? UIImage(named: "profile")!
            //                                    Image(uiImage: placeImage)
            //                                        .resizable()
            //                                        .aspectRatio(contentMode: .fit)
            //                                        .frame(maxWidth: .infinity, maxHeight: 250)
            //                                        .clipShape(RoundedRectangle(cornerRadius: 10))
            //                                }
            //                            }
            //                        }
            //                    }
            //                }
            //            }
            List {
                ForEach( plannedList, id: \.id) { product in
                    let _ = print("data", product)
                    ZStack(alignment: .leading){
                        ProductCardHomeView(data: product)
                        
                            .listRowSeparator(.hidden)
                        NavigationLink(destination: DetailProductView(data: product)){
                        }
                        .opacity(0.0)
                    }
                }
            }
            .listStyle(.plain)
            
        }.onAppear{
            // Product is added to plannedList if product id is equal to Coredata plannedId
            plannedList = vm.allData?.data.product.filter { product in
                vvm.savedSetting.contains {  place in
                    place.placeId == product.id
                }
            } ?? [ProductResponse.Product]()
        }
    }
}

struct VisitedPlaces_Previews: PreviewProvider {
    static var previews: some View {
        VisitedPlacesView()
    }
}
