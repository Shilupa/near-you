//
//  SearchView.swift
//  NearYou
//
//  Created by iosdev on 20.4.2023.
//

import SwiftUI

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @EnvironmentObject var vm: DataViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search")
                    .padding()
                List {
                    ForEach(vm.allData?.data.product ?? [] , id: \.id) { product in
                        
                        NavigationLink(destination: DetailProductView(data: product)){
                            
                            ProductCardHomeView(data: product)
                                .listRowSeparator(.hidden)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.horizontal)
            TextField(placeholder, text: $text)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            Button(action: {
                //button action 
            }, label: {
                Image(systemName: "mic.fill")
                    .foregroundColor(.gray)
            })
            .padding(.horizontal)
        }
        .frame(height: 40)
        .padding(.vertical, 10)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
}

