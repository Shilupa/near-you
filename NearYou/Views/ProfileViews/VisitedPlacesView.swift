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
    @State var visitedList = [ProductResponse.Product]()
    
    var body: some View {
        ZStack {
            List {
                // iterate through each visited product and create a ProductCardHomeView for each
                ForEach( visitedList, id: \.id) { product in
                    // place the ProductCardHomeView inside a ZStack to allow for a hidden NavigationLink to be added
                    ZStack(alignment: .leading){
                        ProductCardHomeView(data: product)
                        
                            .listRowSeparator(.hidden)
                        // create a hidden NavigationLink to the DetailProductView
                        NavigationLink(destination: DetailProductView(data: product)){
                        }
                        .opacity(0.0)
                    }
                }
            }
            .listStyle(.plain)
            
        }.onAppear{
            // Fetching latest data from Core Data
            vvm.fetchSettings()
            // Product is added to plannedList if product id is equal to Coredata plannedId
            visitedList = vm.allData?.data.product.filter { product in
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
