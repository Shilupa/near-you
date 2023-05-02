//
//  CardCategoryView.swift
//  NearYou
//
//  Created by Bibek on 20.4.2023.
//

import SwiftUI

/*
 Design for categories presented in the UI
 */
struct CategoryCardView: View {
    let category: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(category)
                .font(Font.custom("Poppins-Regular", size: 16))
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? Color("ThemeColour") : Color.black)
                .padding()
        }
    }
}
