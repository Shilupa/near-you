//
//  SideMenuView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0xFF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "FBF2B8"), Color(hex: "FACFD9")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    ProfileView(isShowing: $isShowing)
                        .frame(height:300)
                    CombineView()
                    Spacer()
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 100))
            }.navigationBarHidden(true)
        }
    }
    
}

struct ProfileView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject private var lang: LangugageViewModel
    
    var body: some View {
        VStack(){
            ZStack(alignment: .topTrailing){
                VStack{
                    NavigationLink(destination: MainProfileView(), label: {
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
                    
                    Text("Jane Korhonen")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Text("Some street no.15, London")
                        .font(.system(size: 14))
                        .padding(.bottom, 24)
                    
                    HStack(spacing: 12) {
                        Spacer()
                    }
                }
                
            }
            Spacer()
        }.padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
        
    }
}

struct CombineView: View{
    var body: some View {
        VStack{
            MyHomeView()
            LanguageView()
            AboutUsView()
        }.padding(EdgeInsets(top: -20, leading: -20, bottom: 0, trailing: 0))
    }
}
struct MyHomeView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "house.fill")
                    .frame(width:26, height:26)
                    .padding(15)
                Text("Home view")
                    .font(.system(size: 22, weight: .semibold))
                    .environment(\.locale, Locale.init(identifier: lang.currLang))
            }
            ListAndMap()
        }
    }
}

struct LanguageView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "abc")
                    .frame(width:24, height:24)
                    .padding(15)
                Text("Language")
                    .font(.system(size: 22, weight: .semibold))
                    .environment(\.locale, Locale.init(identifier: lang.currLang))
            }
            LanguageOptionView()
        }
    }
}

struct AboutUsView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        
        HStack{
            Image(systemName: "info.circle.fill")
                .frame(width:26, height:26)
                .padding(15)
            Text("About Us")
                .font(.system(size: 22, weight: .semibold))
                .environment(\.locale, Locale.init(identifier: lang.currLang))
        }
        .padding(.trailing, 20)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true)).environmentObject(LangugageViewModel())
    }
}
