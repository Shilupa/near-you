//
//  SideMenuOptionView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI

struct SideMenuOptionView: View {
    let viewModel: SideMenuViewModel
    @EnvironmentObject private var lang: LangugageViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName)
                .frame(width:24, height:24)
                .padding(15)
            
            Text(viewModel.title).environment(\.locale, Locale.init(identifier: lang.currLang))
            // Testing for hard coded value coz original does not work
            //Text("About Us").environment(\.locale, Locale.init(identifier: lang.currLang))
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    
    static var previews: some View {
        SideMenuOptionView(viewModel: .home)
    }
}
