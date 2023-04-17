//
//  NearYouApp.swift
//  NearYou
//
//  Created by Shilpa Singh on 2.4.2023.
//

import SwiftUI
import CoreData

@main
struct NearYouApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(GlobalVarsViewModel())
        }
    }
}
