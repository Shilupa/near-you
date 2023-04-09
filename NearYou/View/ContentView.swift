//
//  ContentView.swift
//  NearYou
//
//  Created by Shilpa Singh on 2.4.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = DataViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    List {
                        ForEach(vm.allData.data.product, id: \.id) { product in
                            
                            Text("Hahaha \(product)")
                            //ProductView(data: product)
//                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Users")
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
