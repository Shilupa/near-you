//
//  HomeListView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 13.4.2023.
//

import SwiftUI

struct HomeListView: View {
    
    //@StateObject var vmh = HelsinkiDataViewModel()
    @StateObject var vm = DataViewModel()
    
//    init(){
//        for familyName in UIFont.familyNames{
//            print(familyName)
//
//            for fontName in UIFont.fontNames(forFamilyName: familyName){
//                print("-- \(fontName)")
//            }
//
//        }
//    }
    
    var body: some View {
        
        
        NavigationView {
            ZStack {
                
                if vm.isRefreshing {
                    ProgressView()
                } else {

                    List {
                        ForEach(vm.allData?.data.product ?? [] , id: \.id) { product in
                           ProductCardHomeView(data: product)
                               .listRowSeparator(.hidden)
                            
                        }
                    }
                    .listStyle(.plain)
                    
                }
            }
            .onAppear(perform: vm.getData)
            .alert(isPresented: $vm.hasError,
                   error: vm.error) {
                Button(action: vm.getData) {
                    Text("Retry")
                }
            }
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
