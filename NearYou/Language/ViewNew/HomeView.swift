//
//  HomeView.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI
import CoreLocationUI

struct HomeView: View {
    
    @AppStorage("selectedView") private var selectedView: Int = 1
    @State private var selectedTab = 1
    @StateObject private var viewModel = MapViewModel()
    @State var searchText = ""
    // Displaying views with desired conditions
    @State private var isShowing: Bool = false
    @State private var showMainView = false
    @EnvironmentObject private var lang: LangugageViewModel
    init() {
        _selectedTab = State(initialValue: selectedView)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.orange], for: .selected)
    }
    var body: some View {
        
        NavigationView{
            let _ = print("isShowing",isShowing)
            ZStack {
                // Displays MainProfileView
                if(showMainView){
                    MainProfileView(isShowing: $isShowing, showMainView: $showMainView)
                }
                // Displays SideMenuView with fraction of MainView
                else if(isShowing){
                    SideMenuView(isShowing: $isShowing, selectedView: $selectedView, showMainView: $showMainView).frame(height: 800)
                    ToggleHomeView(selectedView: $selectedView, selectedTab: $selectedTab).cornerRadius(isShowing ? 20 : 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: isShowing ? 20 : 10)
                                .stroke(Color.orange.opacity(2), lineWidth: 2)
                                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        )
                        .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                        .scaleEffect(isShowing ? 0.8 : 1)
                    // Disables MainView
                        .allowsHitTesting(false)
                }
                // Displays MainView
                else{
                    ToggleHomeView(selectedView: $selectedView, selectedTab: $selectedTab)
                }
                VStack{
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(Color(.systemGray6).opacity(0.7))
                            .cornerRadius(10)
                            .frame(height: 120)
                            .ignoresSafeArea()
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
                            }else if(!showMainView){
                                Button(action: {
                                    withAnimation(.spring()) {
                                        isShowing.toggle()
                                    }
                                },label: {
                                    Image(systemName: "arrowshape.turn.up.backward.fill")
                                        .imageScale(.large)
                                        .colorMultiply(Color.black.opacity(0.8))
                                        .padding(32)
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
                    }
                    Spacer()
                }
            }
        }
    }
}

// Conditional view rendering between MapView and HomeListView
struct ToggleHomeView: View {
    @Binding var selectedView: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        if(selectedTab == 0){
            HomeListView()
                .padding(.top, 60)
        }else{
            MapView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(LangugageViewModel())
    }
}
