//
//  SideMenuView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                SideMenuHeaderView(isShowing: $isShowing)
                    .frame(height:300)
                
                ForEach(SideMenuViewModel.allCases, id: \.self) {option in
                    
                    SideMenuOptionView(viewModel:option)
                        
                    if(option.title == "Language"){
                        LanguageView()
                    }else if(option.title == "Home view"){
                        HomView()
                    }
                    
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct LanguageView : View {
    var body: some View {
            HStack{
                Button("En", action: {})
                Text("|")
                Button("Fi", action: {})
                Text("|")
                Button("SV", action: {})
            }
        }
    }


struct HomView : View {
    var body: some View {
            HStack{
                Button("List", action: {})
                Text("|")
                Button("Map", action: {})
            }
        }
        
    }

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
