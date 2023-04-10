//
//  LanguageViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 10.4.2023.
//

import Foundation

class LangugageViewModel: ObservableObject {
    @Published internal var currLang: String = "en"
    
    func updateLang(lang: String){
        self.currLang = lang
    }
}
