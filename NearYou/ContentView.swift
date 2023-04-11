//
//  ContentView.swift
//  NearYou
//
//  Created by Shilpa Singh on 2.4.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HomeView().environmentObject(LangugageViewModel())
        //HamburgerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(LangugageViewModel())
    }
}
