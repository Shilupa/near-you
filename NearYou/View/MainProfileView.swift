//
//  MainProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 15.4.2023.
//

import SwiftUI

struct MainProfileView: View {
    // Variables passed as params from HomeView
    @Binding var isShowing: Bool
    @Binding var showMainView: Bool
    
    @EnvironmentObject private var lang: LangugageViewModel
    
    var body: some View {
        NavigationView {
            NavigationLink(destination:
                            // Hides navigator default back button during navigation
                           HomeView().navigationBarBackButtonHidden(true), label: {
                VStack(alignment: .center) {
                    Text("Profile view").environment(\.locale, Locale.init(identifier: lang.currLang))
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
            // Event listner when navigation is done
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
