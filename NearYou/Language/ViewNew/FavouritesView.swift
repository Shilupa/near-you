//
//  FavouritesView.swift
//  NearYou
//
//  Created by Shilpa Singh on 24.4.2023.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject private var fvm = FavouritesViewModel()
    @EnvironmentObject var vm: DataViewModel
    @State var favList = [ProductResponse.Product]()
    
    var body: some View {
        ZStack {
            // Display a list of favorite products
            List {
                // Looping through favList and creating a ProductCardHomeView for each product
                ForEach(favList , id: \.id) { product in
                    ZStack(alignment: .leading){
                        ProductCardHomeView(data: product)
                            .listRowSeparator(.hidden)
                        // Creating a NavigationLink to DetailProductView with the current product as data
                        NavigationLink(destination: DetailProductView(data: product)){
                        }
                        // Making the NavigationLink invisible
                        .opacity(0.0)
                    }
                }
            }
            .listStyle(.plain)
            
        }.onAppear{
            // Fetching latest data from Core Data
            fvm.fetchSettings()
            // Product is added to favList if product id is equal to Coredata favouriteId
            favList = vm.allData?.data.product.filter { product in
                fvm.savedSetting.contains { fav in
                    fav.favouriteId == product.id
                }
            } ?? [ProductResponse.Product]()
        }
    }
    
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
