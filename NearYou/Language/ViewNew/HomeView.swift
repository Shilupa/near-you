//
//  HomeView.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI
import CoreLocationUI

struct HomeView: View {
    
    //    @AppStorage("selectedView") private var selectedView: Int = 1
    //    @State private var selectedTab = 1
    @StateObject private var viewModel = MapViewModel()
    @State var searchText = ""
    // Displaying views with desired conditions
    //    @State private var isShowing: Bool = false
    //    @State private var showMainView = false
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    //    init() {
    //        _selectedTab = State(initialValue: selectedView)
    //        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.orange], for: .selected)
    //    }
    var body: some View {
        ZStack {
            let _  = print("showProfileView", gvvm.showProfileView)
            let _  = print("showSideView", gvvm.showSideView)
            let _  = print("showBackButton", gvvm.showBackButton)
            
            // Displays SideMenuView with fraction of MainView
            // Displays MainProfile when gvvm.showProfileView is true
            if(gvvm.showSideView){
                MixedView().fullScreenCover(isPresented: $gvvm.showProfileView) {
                    MainProfileView()
                }
            }
            // Displays MainView
            else{
                ToggleHomeView()
            }
            VStack{
                HStack (alignment: .top){
                    ZStack{
                        if(gvvm.showHamButton){
                            Button(action: {
                                gvvm.updateShowSideView(true)
                                gvvm.updateShowBackButton(true)
                                gvvm.updateShowHamButton(false)
                            },label: {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                                    .padding(25)
                            })
                        }else if(gvvm.showBackButton){
                            Button(action: {
                                gvvm.updateShowSideView(false)
                                gvvm.updateShowBackButton(false)
                                gvvm.updateShowHamButton(true)
                            },label: {
                                Image(systemName: "arrowshape.turn.up.backward.fill")
                                    .imageScale(.large)
                                    .colorMultiply(Color.black.opacity(0.8))
                                    .padding(32)
                            })
                        }
                    }
                    
                    Spacer()
                    
                    if(gvvm.showHamButton){
                        Picker(selection: $gvvm.selectedTab, label: Text("Select a Tab")){
                            
                            Text("List").tag(0).environment(\.locale, Locale.init(identifier: gvvm.currLang))
                            Text("Map").tag(1).environment(\.locale, Locale.init(identifier: gvvm.currLang))
                            
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
        
    }
}

// Mixed view of SideMenuView and ToggleHomeView
struct MixedView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    var body: some View {
        SideMenuView().frame(height: 800)
        ToggleHomeView().cornerRadius(gvvm.showSideView ? 20 : 10)
            .overlay(
                RoundedRectangle(cornerRadius: gvvm.showSideView ? 20 : 10)
                    .stroke(Color.orange.opacity(2), lineWidth: 2)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
            )
            .offset(x: gvvm.showSideView ? 300 : 0, y: gvvm.showSideView ? 44 : 0)
            .scaleEffect(gvvm.showSideView ? 0.8 : 1)
        // Disables MainView
            .allowsHitTesting(false)
    }
}

// Conditional view rendering between MapView and HomeListView
struct ToggleHomeView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    var body: some View {
        if(gvvm.selectedTab == 0){
            HomeListView()
                .padding(.top, 60)
        }else{
            MapView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(GlobalVarsViewModel())
    }
}
