//
//  CustomAnnotationView.swift
//  NearYou
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct CustomAnnotationView: View {
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(.red)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct CustomAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAnnotationView()
    }
}