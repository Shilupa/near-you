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
    @State private var selectedTab = "Favourites"
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "FBF2B8"), Color(hex: "FACFD9")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
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
                    
                    Text("Jane Korhonen")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 8)
                    
                    Text("Some street no.15, London")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    
                    HStack(spacing: 0) {
                        ForEach(["Favourites", "Planned", "Visited"], id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }, label: {
                                Text(tab)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 22)
                                    .padding(.vertical, 8)
                            })
                            .background(
                                selectedTab == tab ? Color.orange : Color.gray.opacity(0.4)
                            )
                            .cornerRadius(0)
                        }
                    }
                    
                    .frame(height: 40)
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
    }
}



struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainProfileView()
            .environmentObject(GlobalVarsViewModel())
    }
}

// Event listener when navigation is done
//                .simultaneousGesture(TapGesture().onEnded{
//                    showMainView = false
//                    isShowing = false
//                })
