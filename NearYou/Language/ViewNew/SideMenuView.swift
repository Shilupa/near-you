//
//  SideMenuView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI

// Sample for add padding to all direction in Vstack
// To be deleted later
// VStack{
//    bla bla bla
// }.padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedView: Int
    @Binding var showMainView: Bool
    @EnvironmentObject private var lang: LangugageViewModel
    
    var body: some View {
        // Added entire view for navigation to get full view for navigated screen
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "FBF2B8"), Color(hex: "FACFD9")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    ProfileView(isShowing: $isShowing, showMainView: $showMainView)
                        .frame(height:300)
                    // Contains MyHomeView, LanguageView & AboutUsView
                    CombineView(selectedView: $selectedView)
                    Spacer()
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 100))
            }.navigationBarHidden(true)
        }
    }
}

// User profile
struct ProfileView: View {
    // Variables passed as params from HomeView
    @Binding var isShowing: Bool
    @Binding var showMainView: Bool
    
    @EnvironmentObject private var lang: LangugageViewModel
    
    var body: some View {
        VStack(){
            ZStack(alignment: .topTrailing){
                VStack{
                    // Navigation to MainProfileView on user image click
                    NavigationLink(destination: MainProfileView(isShowing: $isShowing, showMainView: $showMainView).navigationBarBackButtonHidden(true), label: {
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
                    // Event listner when navigation is done
                    .simultaneousGesture(TapGesture().onEnded{
                        // Hides MainView when showMainView is true
                        showMainView = true
                    })
                    
                    Text("Jane Korhonen")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Text("Some street no.15, London")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 24)
                    
                    HStack(spacing: 12) {
                        Spacer()
                    }
                }
                
            }
            Spacer()
        }.padding(.top, 50)
    }
}

struct CombineView: View{
    @Binding var selectedView: Int
    var body: some View {
        VStack{
            MyHomeView(selectedView: $selectedView)
            LanguageView()
            AboutUsView()
        }.padding(EdgeInsets(top: -20, leading: -20, bottom: 0, trailing: 0))
    }
}

struct MyHomeView: View {
    @Binding var selectedView: Int
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "house.fill")
                    .frame(width:26, height:26)
                    .padding(15)
                Text("Default view")
                    .font(.system(size: 22, weight: .semibold))
                    .environment(\.locale, Locale.init(identifier: lang.currLang))
            }.padding(.leading, 22)
            ListAndMap(selectedView: $selectedView)
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
        SideMenuView(isShowing: .constant(true),
                     selectedView: .constant(1), showMainView: .constant(true)
        ).environmentObject(LangugageViewModel())
    }
}