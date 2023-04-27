//
//  SplashScreenView.swift
//  NearYou
//
//  Created by Shilpa Singh on 27.4.2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isShowingHomeView = false
    
    var body: some View {
        ZStack {
            Image("finland")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.5))
            
            VStack {
                Spacer()
                
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, -50)
                
                Text("NEAR YOU")
                    .font(Font.custom("Poppins-Bold", size: 48))
                    .foregroundColor(.yellow)
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 4)
                    .padding(.bottom, 16)
                
                Text("Discover Finland at your fingertips with Near You")
                    .font(Font.custom("Poppins-Regular", size: 19))
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.8), radius: 2, x: 0, y: 2)
                    .multilineTextAlignment(.center) // align text in the center
                    .padding(.horizontal, 32) // add horizontal padding
                    .padding(.bottom, 32)
                
                Button(action: {
                    isShowingHomeView = true // set state to true to trigger navigation
                }) {
                    Text("Start Exploring")
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Regular", size: 20))
                        .padding(.horizontal, 32) // add horizontal padding
                        .padding(.vertical, 16)
                        .background(Color("ThemeColour")) // use orange as the theme color
                        .cornerRadius(8)
                        .shadow(color: Color("ThemeColour").opacity(0.5), radius: 6, x: 0, y: 3)
                }
                .padding(.horizontal, 32) // add horizontal padding
                
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            .fullScreenCover(isPresented: $isShowingHomeView) {
                HomeView()
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
