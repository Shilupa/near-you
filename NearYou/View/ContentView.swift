//
//  ContentView.swift
//  NearYou
//
//  Created by Shilpa Singh on 2.4.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = DataViewModel()
    
//    func printProduct(){
//        print("Hahaha: ", vm.allData?.data.product ?? "Haha")
//    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    
                    // Button("Press", action: printProduct)
                    
                    
                    List {
                        ForEach(vm.allData?.data.product ?? [], id: \.id) { product in
                            
                        Text(product.productInformations.first?.name ?? "")
                        //Text(product.productInformations.first?.name ?? "")
                            
                        //ProductView(data: product)
//                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Products")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
