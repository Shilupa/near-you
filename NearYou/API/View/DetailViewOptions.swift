//
//  DetailViewOptions.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI
import UIKit
import CoreLocation
import SimpleToast


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
    let destination : CLLocationCoordinate2D
    let data: ProductResponse.Product
    
    @State private var showActionSheet = false
    @State var selectedOption : String
    
    @Binding var showCallToast: Bool
    @Binding var showEmailToast: Bool
    @Binding var selectedLanguageOption : String
    
    var body: some View {
        HStack(alignment: .top){
            
            //Buttom to show map navigation between you and near you
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
            Button(action: {makeCall()
                showCallToast.toggle()
            }) {
                Image(systemName: "phone")
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
            
            
            // language functionality in Website URL
            if let urlLanguage: ProductResponse.ProductInformation = data.productInformations?.first(where: { $0.language == selectedLanguageOption }){
                Button(action: {
                    UIApplication.shared.open(URL(string: urlLanguage.url ?? "www.example.com")!)
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
            }
                 
            
            
            // Button view to send email to the address (doesnot work in the simulator)
            Button(action: {sendEmail()
                showEmailToast.toggle()
            }) {
                Image(systemName: "envelope")
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
            
            
            //Text(selectedOption)
        }
        
        
    }
}

//struct DetailViewOptions_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewOptions()
//    }
//}
