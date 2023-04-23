//
//  MainProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 15.4.2023.
//

import SwiftUI

struct MainProfileView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    // Tracks the selected tab
    @State private var selectedTab = 0
    @State private var profileImage: UIImage?
    @StateObject private var mypvm = MyProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "FBF2B8"), Color(hex: "FACFD9")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .center) {
                    Image(uiImage: gvvm.profileImage!)
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
                    //                    }
                    Text(gvvm.userName)
                        .font(.title)
                        .bold()
                        .padding(.bottom, 8)
                    
                    Text(gvvm.userAddress)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    
                    Picker(selection: $selectedTab, label: Text("Select a Tab")){
                        Text("Favourites").tag(0).environment(\.locale, Locale.init(identifier: gvvm.currLang))
                        Text("Planned").tag(1).environment(\.locale, Locale.init(identifier: gvvm.currLang))
                        Text("Visited").tag(2).environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom, 24)
                    .padding(.horizontal, 16)
                    
                    Spacer()
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
                                    .padding(.trailing, 8)
                            }
                        )
                )
            }
        }
        // When view is loaded these values are set
        .onAppear{
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

struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainProfileView()
            .environmentObject(GlobalVarsViewModel())
    }
}

