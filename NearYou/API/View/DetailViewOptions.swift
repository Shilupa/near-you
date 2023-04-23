//
//  DetailViewOptions.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI
import UIKit
import CoreLocation

func goNavigation () {
    
}

func makeCall () {
    
    let phoneNumber = "+358442311309"
    
    if let phoneCallURL = URL(string: "tel:\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
}





struct DetailViewOptions: View {
    
    let websiteURL: String

    
    
    @State var destination : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.71, longitude: -74)
    
    var body: some View {
        HStack(alignment: .top){
//            Button(action: goNavigation) {
//                Image(systemName: "arrow.triangle.turn.up.right.diamond")
//                    .frame(width: 50, height: 50)
//                    .padding(10)
//                    .foregroundColor(.white)
//                    .background(LinearGradient(
//                        gradient: Gradient(
//                            colors: [Color("ThemeColour"), Color("ThemeColourLight")]),
//                        startPoint: .top,
//                        endPoint: .bottom))
//
//                    .cornerRadius(20)
//                    .font(.system(size: 40))
//
//            }.shadow(color: Color.gray, radius: 7, x: 0, y: 2)
//                .padding(5)
            
            NavigationLink(destination: DirectionsView(destination: destination)) {
                                Image(systemName: "arrow.triangle.turn.up.right.diamond")
                                    .frame(width: 50, height: 50)
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(LinearGradient(
                                        gradient: Gradient(
                                            colors: [Color("ThemeColour"), Color("ThemeColourLight")]),
                                        startPoint: .top,
                                        endPoint: .bottom))
                                    .cornerRadius(20)
                                    .font(.system(size: 40))
                            }.shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                            .padding(5)
            
            Button(action: makeCall) {
                Image(systemName: "phone")
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .font(.system(size: 40))
                
            }.shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                .padding(5)
            
            
            
            Button(action: {
                UIApplication.shared.open(URL(string: websiteURL)!)
            }) {
                Image(systemName: "network")
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(LinearGradient(
                        gradient: Gradient(
                            colors: [Color("ThemeColour"), Color("ThemeColourLight")]),
                        startPoint: .top,
                        endPoint: .bottom))
                
                    .cornerRadius(20)
                    .font(.system(size: 40))
                
            }.shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                .padding(5)
            
            
            Button(action: goNavigation) {
                Image(systemName: "envelope")
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(20)
                    .font(.system(size: 40))
                
            }.shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                .padding(5)
            
        }
        
        
    }
}

//struct DetailViewOptions_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewOptions()
//    }
//}
