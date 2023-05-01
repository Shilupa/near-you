//
//  LanguageViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 10.4.2023.
//

import Foundation
import SwiftUI

// Class to store global variables
class GlobalVarsViewModel: ObservableObject {
    @Published internal var currLang: String = "en"
    @Published internal var showProfileView: Bool = false
    @Published internal var showSideView: Bool = false
    @Published internal var showBackButton: Bool = false
    @Published internal var showHamButton: Bool = true
    @Published internal var profileImage: UIImage?
    @Published internal var userName: String = "Not Set"
    @Published internal var userAddress: String = "Not Set"
    
    // Updates language
    func updateLang(_ lang: String){
        self.currLang = lang
    }

    // Updates user profile visibility to true or false
    func updateShowProfileView(_ showProfile: Bool){
        self.showProfileView = showProfile
    }
    
    // Update sideMenuView visibility to true or false
    func updateShowSideView(_ sideView: Bool){
        self.showSideView = sideView
    }
    
    // Update sideMenuView  back button visibility to true or false
    func updateShowBackButton(_ showBackButton: Bool){
        self.showBackButton = showBackButton
    }
    
    // Update hamnburger menu button visibility to true or false
    func updateShowHamButton(_ showHamButton: Bool){
        self.showHamButton = showHamButton
    }
}
