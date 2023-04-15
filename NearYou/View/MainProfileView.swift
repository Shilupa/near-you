//
//  MainProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 15.4.2023.
//

import SwiftUI

struct MainProfileView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject private var lang: LangugageViewModel
    @Binding var showMainView: Bool
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), label: {
                VStack(alignment: .center) {
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 135, height: 135)
                        .clipShape(Circle())
                    
                        .overlay(
                            Circle()
                                .stroke(Color.orange, lineWidth: 3)
                        )
                        .padding(.bottom, 16)
                }
            })
            
            .simultaneousGesture(TapGesture().onEnded{
                showMainView = false
                isShowing = false
            })
        }
    }
}

struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainProfileView(isShowing: .constant(true),
                        showMainView: .constant(true)
           ).environmentObject(LangugageViewModel())
    }
}
