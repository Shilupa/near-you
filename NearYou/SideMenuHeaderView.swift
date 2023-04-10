//
//  SideMenuHeaderView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            Button(action: {withAnimation(.spring()) {
                isShowing.toggle()
            }}, label: {
                Image(systemName: "xmark")
                    .frame(width: 100, height: 32)
                    .padding()
            })
            VStack(alignment: .leading) {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    .overlay(
                            Circle()
                                .stroke(Color.orange, lineWidth: 3)
                        )
                    .padding(.bottom, 16)
                
                Text("Jane Korhonen")
                    .font(.system(size: 24, weight: .semibold))
                
                Text("Some street no.15, London")
                    .font(.system(size: 14))
                    .padding(.bottom, 24)
                
                HStack(spacing: 12) {
                    Spacer()
                }
                
                Spacer()
            }.padding()
        }
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
