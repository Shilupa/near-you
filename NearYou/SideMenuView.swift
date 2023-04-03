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
                    .frame(height:240)
                
                ForEach(SideMenuViewModel.allCases, id: \.self) {option in
                    NavigationLink(
                        destination: Text(option.title),
                                          label: {
                                              SideMenuOptionView(viewModel:option)
                                          })
                    
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
            Button("Fi", action: {})
            Button("SV", action: greeting)
        }
    }
}
func greeting() {
       print("Hello, World!")
   }

struct HomView : View {
    var body: some View {
        HStack{
            Text("List")
            Text("|")
            Text("Map")
        }
    }
}


struct Test1View : View {


    var body: some View {
        Text("test")
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
