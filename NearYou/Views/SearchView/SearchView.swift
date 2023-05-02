//
//  SearchView.swift
//  NearYou
//
//  Created by Bibek on 20.4.2023.
//

import SwiftUI

/*
 UI View where users are able to search for locations
 */
struct SearchView: View {
    @State var searchText = ""
    @State var isRecording = false
    @EnvironmentObject var vm: DataViewModel
    @State private var filteredList: [ProductResponse.Product] = []
    @State private var categories : [String] = []
    @State  var selectedCategory : String? = ""
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    
    var body: some View {
        
        if vm.isRefreshing {
            ProgressView()
            Spacer()
        } else {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search", onSearch: performSearch, onClear: {
                    // Unselect category when search text is cleared
                    selectedCategory = nil
                    performSearch()
                })
                .padding(.horizontal)
                
                categoriesSection
                productsListSection
                
            }
            .onAppear(perform: makeCategories)
            .onAppear(perform: performSearch)
            .onChange(of: searchText) { _ in
                performSearch()
            }
        }
        
    }
    
    //Function to perform search
    private func performSearch() {
        // Clear selected category if search text is empty
        if searchText.isEmpty {
            selectedCategory = nil
        }
        //Filtering data based on key search words
        if let allData = vm.allData {
            filteredList = allData.data.product.filter { product in
                let containsKeyword = product.productInformations?.contains { information in
                    if let description = information.description {
                        return description.localizedCaseInsensitiveContains(searchText)
                    } else {
                        return false
                    }
                }
                return containsKeyword ?? false
            }
        }
    }
    
    //Function to make categories from types of the products
    private func makeCategories() {
        if let allData = vm.allData {
            let types = allData.data.product.compactMap { $0.type }
            categories = Array(Set(types)).sorted()
            categories.insert("All", at: 0)
        }
    }
    
    //Function to check if categories are selected
    private func didSelectCategory(_ category: String) {
        selectedCategory = category
        searchText = (selectedCategory == "All" ? "" : selectedCategory) ?? ""
        performSearch()
    }
}


extension SearchView {
    //Scrollable view of all the categories
    private var categoriesSection : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(categories, id: \.self) { category in
                    CategoryCardView(category: category.capitalized.replacingOccurrences(of: "_", with: " "), isSelected: category == selectedCategory)
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
    }
    
    //List of filtered list
    private var productsListSection : some View {

            List {
                ForEach(filteredList, id: \.id) { product in
                    ZStack(alignment: .leading){
                        ProductCardHomeView(data: product)
                            .listRowSeparator(.hidden)
                        //Hiding navigation link arrow shown on the card
                        NavigationLink(destination: DetailProductView(data: product)){
                        }
                        .opacity(0.0)
                    }
                }
            }
            .listStyle(.plain)

    }
}
