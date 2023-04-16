//
//  MainProfileView.swift
//  NearYou
//
//  Created by Shilpa Singh on 15.4.2023.
//

import SwiftUI

struct MainProfileView: View {
    // Variables passed as params from HomeView
    @Binding var isShowing: Bool
    @Binding var showMainView: Bool
    
    @EnvironmentObject private var lang: LangugageViewModel
    
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
                        .padding(.bottom, 24)
                    
                    Spacer()
                    
                    
                }
                
                .navigationBarTitle("")
                .navigationBarItems(
                    leading:
                        NavigationLink(
                            destination: SideMenuView(isShowing: .constant(true),
                                                      selectedView: .constant(1), showMainView: .constant(true)).navigationBarBackButtonHidden(true),
                            label: {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.primary)
                                    .imageScale(.large)
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
                
                // Event listener when navigation is done
//                .simultaneousGesture(TapGesture().onEnded{
//                    showMainView = false
//                    isShowing = false
//                })
            }
        }
    }
}

struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainProfileView(isShowing: .constant(true),
                        showMainView: .constant(true))
        .environmentObject(LangugageViewModel())
    }
}
