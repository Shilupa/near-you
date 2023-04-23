//
//  SearchView.swift
//  NearYou
//
//  Created by iosdev on 20.4.2023.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @EnvironmentObject var vm: DataViewModel
    @State private var filteredList: [ProductResponse.Product] = []
    @State private var categories : [String] = []
    @State private var selectedCategory : String?

    
    private func performSearch() {
        if let allData = vm.allData {
            filteredList = allData.data.product.filter { product in
                let containsKeyword = product.productInformations.contains { information in
                    if let description = information.description {
                        return description.localizedCaseInsensitiveContains(searchText)
                    } else {
                        return false
                    }
                }
                return containsKeyword
            }
        }
    }
    
    private func makeCategories() {
        if let allData = vm.allData {
            let types = allData.data.product.compactMap { $0.type }
            categories = Array(Set(types)).sorted()
        }
    }
    
    private func didSelectCategory(_ category: String) {
        selectedCategory = category
        searchText = category
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search", onSearch: performSearch)
                    .padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(categories, id: \.self) { category in
                            CategoryCardView(category: category, isSelected: category == selectedCategory)
                                .padding(.horizontal, 2)
                                .onTapGesture {
                                    selectedCategory = category == selectedCategory ? nil : category
                                    searchText = selectedCategory ?? ""
                                    performSearch()
                                }
                        }
                    }
                }
                .frame(height: 40)
                .padding(.horizontal)
            
                
                List {
                    ForEach(filteredList, id: \.id) { product in
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
            }
            .onAppear(perform: makeCategories)
        }
        .onChange(of: searchText) { _ in
            performSearch()
                
            
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.horizontal)
            TextField(placeholder, text: $text, onCommit: onSearch)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onSearch()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            Button(action: {
                // button action
            }, label: {
                Image(systemName: "mic.fill")
                    .foregroundColor(.gray)
            })
            .padding(.horizontal)
        }
        .frame(height: 30)
        .padding(.vertical, 10)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
}

struct CategoryCardView: View {
    let category: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Text(category)
                .font(.headline)
                .foregroundColor(.black)
                .padding()
        }
        .frame(width: .none, height: 40)
        .background(isSelected ? Color.orange : Color(.systemGray6))
        .cornerRadius(10)
    }
}
