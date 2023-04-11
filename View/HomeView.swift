//
//  HomeView.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI
import CoreLocationUI

struct HomeView: View {
    init(){
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.orange], for: .selected)
    }
    @State private var selectedTab = 1
    @State private var showMenu = false
    @StateObject private var viewModel = MapViewModel()
    @State var searchText = ""
    @State private var isShowing = false
    @EnvironmentObject private var lang: LangugageViewModel
    
    var body: some View {
        
        NavigationView{
            let _ = print("isShowing",isShowing)
            ZStack {
                if(isShowing == true){
                    SideMenuView(isShowing: $isShowing).frame(height: 800)
                    MainView(selectedTab: $selectedTab).cornerRadius(isShowing ? 20 : 10)
                        .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                        .scaleEffect(isShowing ? 0.8 : 1)
                }else{
                    MainView(selectedTab: $selectedTab)
                }
                
                VStack{
                    HStack (alignment: .top){
                        ZStack{
                            if(!isShowing){
                                Button(action: {
                                    withAnimation(.spring()) {
                                        isShowing.toggle()
                                    }
                                },label: {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                        .padding(25)
                                })
                            }
                        }
                        
                        Spacer()
                        
                        if(!isShowing){
                            Picker(selection: $selectedTab, label: Text("Select a Tab")){
                                
                                Text("List").tag(0).environment(\.locale, Locale.init(identifier: lang.currLang))
                                Text("Map").tag(1).environment(\.locale, Locale.init(identifier: lang.currLang))
                                
                            }
                            .background(Color.white.cornerRadius(10))
                            .foregroundColor(.blue)
                            .frame(width: 130)
                            .padding()
                            .cornerRadius(20)
                            .font(.headline)
                            .pickerStyle(SegmentedPickerStyle())
                            
                            Spacer()
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemGray6))
                                    .frame(width: 30, height: 30)
                                
                                Image(systemName: "mappin")
                                    .imageScale(.medium)
                                    .padding(25)
                            }
                        }
                        
                    }
                    Spacer()
                    
                }
            }
            .onAppear{
                isShowing = true
            }
        }
    }
}

// Conditional view rendering between MapView and HomeListView
struct MainView: View {
    @Binding var selectedTab: Int
    var body: some View {
        if(selectedTab == 0){
            HomeListView()
        }else{
            MapView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
