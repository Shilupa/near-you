//
//  DetailViewOptions.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI
import UIKit
import CoreLocation


func sendEmail () {
    
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

            // Buttom to show map navigation between you and near you
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
            
            
            // Button view to make call (Doesnot work in the simulator)
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
            
            
            // Button view to navigate to the URL link
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
            
            // Button view to send email to the address (doesnot work in the simulator)
            Button(action: sendEmail) {
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
