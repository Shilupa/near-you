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
            // Background image with gradient overlay
            Image("finland") .resizable() .scaledToFill() .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity) .edgesIgnoringSafeArea(.all) .overlay(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom))
            
            // Main content of splash screen
            VStack {
                Spacer()
                
                // App logo
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, -50)
                    .shadow(color: Color.white.opacity(0.5), radius: 10)
                
                // Title text
                Text("NEAR YOU")
                    .font(Font.custom("Poppins-Bold", size: 48))
                    .foregroundColor(.yellow)
                    .shadow(color: Color.black.opacity(0.8), radius: 4, x: 0, y: 4)
                    .padding(.bottom, 16)
                
                // Subtitle text
                Text("Discover Finland at your fingertips with Near You")
                    .font(Font.custom("Poppins-Regular", size: 19))
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.8), radius: 2, x: 0, y: 2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                
                // Button to start exploring
                Button(action: {
                    // Set state to true to trigger navigation
                    isShowingHomeView = true
                }) {
                    Text("Start Exploring")
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Regular", size: 20))
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(Color("ThemeColour"))
                        .cornerRadius(50)
                        
                }
                .padding(.horizontal, 32)
                .shadow(color: Color.white.opacity(0.5), radius: 10)
                
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
            // Full screen cover to navigate to home view
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
