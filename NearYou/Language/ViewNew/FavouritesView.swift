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
            List {
                ForEach(favList , id: \.id) { product in
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
