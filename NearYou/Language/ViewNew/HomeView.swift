//
//  HomeView.swift
//  NearYou
//
//  Created by iosdev on 5.4.2023.
//

import SwiftUI
import CoreLocationUI

struct HomeView: View {
    
    @StateObject var viewModel = MapViewModel()
    @State var searchText = ""
    @State private var isShowing: Bool = false
    @State private var showMainView = false
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    @StateObject private var dvm = DefaultViewModel()
    @StateObject private var dlvm = DefaultLangViewModel()
    @State private var selectedTab = 0
    @StateObject private var mypvm = MyProfileViewModel()
    @State private var listOrMap = false
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(named: "ThemeColour")!], for: .selected)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Displays SideMenuView with fraction of MainView
                // Displays MainProfile when gvvm.showProfileView is true
                if(gvvm.showSideView){
                    MixedView(selectedTab: $selectedTab).fullScreenCover(isPresented: $gvvm.showProfileView) {
                        MainProfileView()
                    }
                }
                // Displays MainView
                else{
                    ToggleHomeView(selectedTab: $selectedTab)
                }
                VStack{
                    
                    ZStack (alignment: .top){
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1.0),  Color.white.opacity(1.0),  Color.white.opacity(0.5), Color.white.opacity(0.0)]), startPoint: .top, endPoint: .bottom))
                            .frame(height: 110)
                            .ignoresSafeArea()
                        
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
                                            .accentColor(Color("ThemeColour"))
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
                                Picker(selection: $selectedTab, label: Text("Select a Tab")){
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
                                
                                Image("AppIconLogo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 20)
                                    .padding(.top, 8)
                            }
                        }}
                    Spacer()
                }
            }
            // When view is loaded these values are set
            .onAppear{
                gvvm.currLang =  dlvm.savedSetting.last?.myLang ?? "en"
                // List or Map value is loaded only once
                if(!listOrMap){
                    selectedTab = Int(dvm.savedSetting.last?.listOrMap ?? 0)
                }
                // Prohibits to fetch value default value of list or map more than once from CoreData
                listOrMap = true
                if(mypvm.savedSetting.last?.my_Image == nil){
                    gvvm.profileImage = UIImage(named: "profile")
                }else{
                    gvvm.profileImage = UIImage(data: (mypvm.savedSetting.last?.my_Image)!)
                    gvvm.userName = mypvm.savedSetting.last?.my_Name ?? "Not Set"
                    gvvm.userAddress = mypvm.savedSetting.last?.my_Address ?? "Not Set"
                }
            }
        }
        
    }
}

// Mixed view of SideMenuView and ToggleHomeView
struct MixedView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        SideMenuView().frame(height: 800)
        ToggleHomeView(selectedTab: $selectedTab).cornerRadius(gvvm.showSideView ? 20 : 10)
            .overlay(
                RoundedRectangle(cornerRadius: gvvm.showSideView ? 20 : 10)
                    .stroke(Color("ThemeColour").opacity(2), lineWidth: 2)
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
    //@Binding var selectedView: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        if(selectedTab == 0){
            SearchView(searchText: "All", isRecording: false, selectedCategory: "All")
                .environmentObject(MapViewModel())
                .padding(.top, 60)
        }else{
                MapView()
                    .environmentObject(MapViewModel())
//            DraggablePins()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(GlobalVarsViewModel())
    }
}
