//
//  SideMenuView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                SideMenuHeaderView(isShowing: $isShowing)
                    .frame(height:300)
                
                ForEach(SideMenuViewModel.allCases, id: \.self) {option in
                    
                    SideMenuOptionView(viewModel:option)
                    
                    if(option.title == "Language"){
                        LanguageView()
                    }else if(option.title == "Home view"){
                        HomView()
                    }
                    
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct RoundedButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .foregroundColor(foregroundColor)
            .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(backgroundColor)
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(Color.orange, lineWidth: 2)
                            }
                        )
            .clipShape(RoundedRectangle(cornerRadius: 15.0))
            .frame(height: 30)
    }
}

struct LanguageView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    @State private var selectedLang: String = ""
    @State private var selectedButton: String? = "en"

    var body: some View {
        HStack {
            Button(action: {
                lang.updateLang(lang: "fi")
                selectedLang = "fi"
                selectedButton = "fi"
            }, label: {
                Text("Fi")
            })
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == "fi" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            
            Button(action: {
                lang.updateLang(lang: "en")
                selectedLang = "en"
                selectedButton = "en"
            }, label: {
                Text("En")
            })
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == "en" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            
            Button(action: {
                lang.updateLang(lang: "sv")
                selectedLang = "sv"
                selectedButton = "sv"
            }, label: {
                Text("Sv")
            })
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == "sv" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
        }
    }
}



struct HomView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    @State private var selectedButton: String? = "map"

    var body: some View {
        HStack {
            Button(action: {
                lang.updateLang(lang: "list")
                selectedButton = "list"
            }, label: {
                Text("List")
            })
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == "list" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            .environment(\.locale, Locale(identifier: lang.currLang))

            Text("|")

            Button(action: {
                lang.updateLang(lang: "map")
                selectedButton = "map"
            }, label: {
                Text("Map")
            })
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == "map" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            .environment(\.locale, Locale(identifier: lang.currLang))
        }
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
