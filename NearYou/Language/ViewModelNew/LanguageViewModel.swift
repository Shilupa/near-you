//
//  LanguageViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 10.4.2023.
//

import Foundation
import SwiftUI
class GlobalVarsViewModel: ObservableObject {
    @Published internal var currLang: String = "en"
    @Published internal var showProfileView: Bool = false
    @Published internal var showSideView: Bool = false
    @Published internal var showBackButton: Bool = false
    @Published internal var showHamButton: Bool = true
    
    @AppStorage("selectedView") internal var selectedView: Int = 1
    @Published internal var selectedTab = 1
    
    init(){
        self.selectedTab = self.selectedView
    }
    
    func updateLang(_ lang: String){
        self.currLang = lang
    }

    func updateShowProfileView(_ showProfile: Bool){
        self.showProfileView = showProfile
    }
    
    func updateShowSideView(_ sideView: Bool){
        self.showSideView = sideView
    }
    
    func updateSelectedView(_ selectedView: Int){
        self.selectedView = selectedView
    }
    
    func updateShowBackButton(_ showBackButton: Bool){
        self.showBackButton = showBackButton
    }
    
    func updateShowHamButton(_ showHamButton: Bool){
        self.showHamButton = showHamButton
    }
}
