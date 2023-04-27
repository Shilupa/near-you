//
//  TabView.swift
//  NearYou
//
//  Created by Shilpa Singh on 14.4.2023.
//

import SwiftUI

struct LanguageTabView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        VStack{
            //            ListAndMap()
            LanguageOptionView()
        }
    }
}

struct ListAndMap: View {
    @Binding var selectedView: Int
    @EnvironmentObject private var lang: LangugageViewModel
    
    var body: some View {
        let _ = print(selectedView)
        HStack {
            Button(action: {
                // Sets list as default view
                selectedView = 0
            }) {
                Text("List")
                    .padding()
                    .font(.system(size: 13))
                    .foregroundColor(selectedView == 0 ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 63)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(selectedView == 0 ? Color.orange : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                        //.stroke(Color.orange, lineWidth: isLeftButtonSelected ? 0 : 1)
                            .stroke(Color.clear, lineWidth: 0)
                    ).environment(\.locale, Locale.init(identifier: lang.currLang))
                //.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
            }
            
            Button(action: {
                // // Sets list as Map default view
                selectedView = 1
            }) {
                Text("Map")
                    .padding()
                    .font(.system(size: 13))
                    .foregroundColor(selectedView == 1 ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 70)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(selectedView == 1 ? Color.orange : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.clear, lineWidth: 0) // remove the border color
                    )
                    .environment(\.locale, Locale.init(identifier: lang.currLang))
            }
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        .mask {
            RoundedRectangle(cornerRadius: 25)
            // or Capsule()
        }
        //.frame(width: 250)
    }
}




struct LanguageOptionView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    @State private var selectedButton: Int = 0
    @FocusState private var defaultButton: Int?
    @AppStorage("selectedLanguage") var selectedLanguage = ""
    
    var body: some View {
        HStack {
            Button(action: {
                lang.updateLang(lang: "fi")
                selectedButton = 1
                defaultButton = 1
                selectedLanguage = "fi"
            }, label: {
                Text("Fi")
            })
            .focused($defaultButton, equals: 1)
            
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == 1 ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            // Default language
            Button(action: {
                lang.updateLang(lang: "en")
                selectedButton = 0
                defaultButton = 0
                selectedLanguage = "en"
            }, label: {
                Text("En")
            })
            .focused($defaultButton, equals: 0)
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == 0 ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            
            Button(action: {
                lang.updateLang(lang: "sv")
                selectedButton = 2
                defaultButton = 2
                selectedLanguage = "sv"
            }, label: {
                Text("Sv")
            })
            .focused($defaultButton, equals: 2)
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == 2 ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
        }.padding(.trailing, 15)
        //setting the value of selectedLanguage
            .onAppear {
                selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? ""
                switch selectedLanguage {
                case "fi":
                    selectedButton = 1
                    defaultButton = 1
                case "sv":
                    selectedButton = 2
                    defaultButton = 2
                default:
                    selectedButton = 0
                    defaultButton = 0
                }
            }
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

struct LanguageTabView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageTabView().environmentObject(LangugageViewModel())
    }
}
