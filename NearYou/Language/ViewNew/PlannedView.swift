//
//  PlannedView.swift
//  NearYou
//
//  Created by Shilpa Singh on 26.4.2023.
//

import SwiftUI

struct PlannedView: View {
    @StateObject private var pvm = PlannedViewModel()
    @EnvironmentObject var vm: DataViewModel
    
    @State var plannedList = [ProductResponse.Product]()
    
    var body: some View {
        ZStack {
            List {
                ForEach(plannedList , id: \.id) { product in
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
            // Fetching latest data from Core Data
            pvm.fetchSettings()
            // Product is added to plannedList if product id is equal to Coredata plannedId
            plannedList = vm.allData?.data.product.filter { product in
                pvm.savedSetting.contains { planned in
                    planned.plannedId == product.id
                }
            } ?? [ProductResponse.Product]()
        }
    }
}

struct PlannedView_Previews: PreviewProvider {
    static var previews: some View {
        PlannedView()
    }
}
