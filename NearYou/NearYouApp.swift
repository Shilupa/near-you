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
    
    @StateObject var vm: DataViewModel = DataViewModel()
    
    
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(GlobalVarsViewModel())
                .environmentObject(DataViewModel())
            //MainView()
        }
    }
}
