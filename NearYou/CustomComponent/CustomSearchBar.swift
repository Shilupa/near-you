//
//  CustomSearchBar.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI

struct CustomSearchBar: View {
    
    @Binding var searchText: String
    @State private var isSearchViewActive = false
    
    var body: some View {
        
        NavigationLink(
            destination: SearchView()
                .environmentObject(MapViewModel())
        ){

        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.white))
                .frame(width: 300, height: 45)
                .shadow(color:.gray,radius: 10)
            
            HStack {
                Button(action: {
                    // Your first button action goes here
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                })
                .disabled(true)
                
                TextField("Search", text: $searchText)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
                    .background(Color(.white))
                    .frame(width: 220)
                    .disabled(true)
                
                Button(action: {
                    // Your second button action goes here
                }, label: {
                    Image(systemName: "mic.fill")
                        .foregroundColor(.gray)
                })
                .disabled(true)
            }
        }
        }

    }
}
