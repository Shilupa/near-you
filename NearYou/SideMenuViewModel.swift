//
//  SideMenuViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import Foundation
import SwiftUI

enum SideMenuViewModel: Int, CaseIterable {
    case home
    case language
    case aboutus
    
    var title: String {
        switch self{
        case .home: return "Home view"
        case .language: return "Language"
        case .aboutus: return "About Us"
        }
    }
    var imageName: String {
        switch self {
        case .home: return "house.fill"
        case .language: return "abc"
        case .aboutus: return "info.circle.fill"
        }
    }
}
