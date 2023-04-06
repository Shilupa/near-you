//
//  CustomSearchBar.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray6))
                .frame(width: 300, height: 40)
            
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
                    .background(Color(.systemGray6))
                    .frame(width: 220)
                
                Button(action: {
                    // Your second button action goes here
                }, label: {
                    Image(systemName: "mic.fill")
                        .foregroundColor(.gray)
                })
            }
        }
    }
}
