//
//  MainProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 15.4.2023.
//

import SwiftUI

struct MainProfileView: View {
    // Environment object
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    
    
    // Tracks the selected tab
    @State private var selectedTab = 0
    
    // State objects
    @State private var profileImage: UIImage?
    @StateObject private var mypvm = MyProfileViewModel()
    @EnvironmentObject var vm: DataViewModel
    @StateObject private var fvm = FavouritesViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 2) {
                Image(uiImage: gvvm.profileImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 135, height: 135)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("ThemeColour"), lineWidth: 5)
                            .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                    )
                Text(gvvm.userName)
                    .font(.custom("Poppins-Bold", size: 25))
                
                Text(gvvm.userAddress)
                    .font(.custom("Poppins-Regular", size: 20))
                    .foregroundColor(.secondary)
                
                Picker(selection: $selectedTab, label: Text("Select a Tab")) {
                    Text("Planned")
                        .tag(0)
                        .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    
                    Text("Visited")
                        .tag(1)
                        .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    
                    Text("Favourites")
                        .tag(2)
                        .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 16)
                .padding(.top, 14)
                
                Spacer()
                MainProfilePickerView(selectedTab: $selectedTab)
            }
            .padding(.horizontal, 16)
            .navigationBarTitle("")
            .navigationBarItems(
                leading:
                    NavigationLink(
                        destination: SideMenuView().navigationBarBackButtonHidden(true),
                        label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primary)
                                .imageScale(.large)
                        })
                // Event listner when navigation is done
                    .simultaneousGesture(TapGesture().onEnded{
                        // Hides MainView when showMainView is true
                        gvvm.updateShowProfileView(false)
                        gvvm.updateShowSideView(true)
                        gvvm.updateShowBackButton(true)
                    }),
                trailing:
                    NavigationLink(
                        destination: EditProfileView(),
                        label: {
                            Image(systemName: "pencil.circle.fill")
                                .foregroundColor(.primary)
                                .imageScale(.large)
                        }
                    )
            )
        }
        // When view is loaded these values are set
        .onAppear {
            if mypvm.savedSetting.last?.my_Image == nil {
                gvvm.profileImage = UIImage(named: "profile")
            } else {
                gvvm.profileImage = UIImage(data: (mypvm.savedSetting.last?.my_Image)!)
                gvvm.userName = mypvm.savedSetting.last?.my_Name ?? "Not Set"
                gvvm.userAddress = mypvm.savedSetting.last?.my_Address ?? "Not Set"
            }
        }
    }
}

struct MainProfilePickerView: View {
    @Binding var selectedTab: Int
    var body: some View {
        // Depending on the selected tab, display a different view.
        // The environmentObject() modifier is used to inject a MapViewModel into each child view.
        if(selectedTab == 0){
            PlannedView()
                .environmentObject(MapViewModel())
        }else if(selectedTab == 2){
            FavouritesView()
                .environmentObject(MapViewModel())
        }else if(selectedTab == 1){
            VisitedPlacesView().environmentObject(MapViewModel())
        }
    }
}


struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainProfileView()
            .environmentObject(GlobalVarsViewModel())
    }
}

