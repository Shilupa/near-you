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
    @State private var isShowing = true
    
    var body: some View {
        
        NavigationView{
            
            ZStack {
                
                if selectedTab == 0 {
                    HomeListView()
                } else {
                    MapView()
                }
                
                VStack{
                    HStack (alignment: .top){
                        
                        
                        ZStack{
                            if isShowing {
                                SideMenuView(isShowing: $isShowing)
                            }
                            SideMenuView(isShowing: $isShowing)
                                .cornerRadius(isShowing ? 20 : 10)
                                .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                                .scaleEffect(isShowing ? 0.8 : 1)
                                .navigationBarItems(leading: Button(action: {
                                    withAnimation(.spring()) {
                                        isShowing.toggle()
                                    }
                                },label: {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                                    .padding(25)
                            }))
                        }
                        
                        Spacer()
                        
                        
                        Picker(selection: $selectedTab, label: Text("Select a Tab")){
                            Text("List").tag(0)
                            Text("Map").tag(1)
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
                    Spacer()
                    
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
