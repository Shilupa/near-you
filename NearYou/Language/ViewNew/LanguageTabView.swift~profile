//
//  TabView.swift
//  NearYou
//
//  Created by Shilpa Singh on 14.4.2023.
//

import SwiftUI

struct LanguageTabView: View {
    @EnvironmentObject private var lang: GlobalVarsViewModel
    var body: some View {
        VStack{
            LanguageOptionView()
        }
    }
}

struct ListAndMap: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    @StateObject private var dvm = DefaultViewModel()
    
    var body: some View {
        HStack {
            Button(action: {
                // Sets list as default view
                dvm.addDefaultView(0)
            }) {
                Text("List")
                    .padding()
                    .font(.system(size: 13))
                    .foregroundColor(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 0 ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 63)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 0 ? Color.orange : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                        //.stroke(Color.orange, lineWidth: isLeftButtonSelected ? 0 : 1)
                            .stroke(Color.clear, lineWidth: 0)
                    ).environment(\.locale, Locale.init(identifier: gvvm.currLang))
                //.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
            }
            
            Button(action: {
                // Sets Map as default view
                dvm.addDefaultView(1)
            }) {
                Text("Map")
                    .padding()
                    .font(.system(size: 13))
                    .foregroundColor(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 1 ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 70)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 1 ? Color.orange : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.clear, lineWidth: 0) // remove the border color
                    )
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
            }
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        .mask {
            RoundedRectangle(cornerRadius: 25)
            // or Capsule()
        }
    }
}


struct LanguageOptionView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    @FocusState private var defaultButton: Int?
    @State private var selectedLanguage = "en"
    @StateObject private var dvm = DefaultViewModel()
    @StateObject private var dlvm = DefaultLangViewModel()
    
    var body: some View {
        
        HStack {
            let _ = print("curr", gvvm.currLang)
            let _ = print("selected", selectedLanguage)
            let _ = print("def", dlvm.savedSetting.last?.myLang ?? "en")
           
            Button(action: {
                gvvm.updateLang("fi")
                dlvm.addDefaultLang("fi")
                defaultButton = 1
                selectedLanguage = "fi"
            }, label: {
                Text("Fi")
            })
            .focused($defaultButton, equals: 1)
            
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedLanguage == "fi" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            // Default language
            Button(action: {
                gvvm.updateLang("en")
                dlvm.addDefaultLang("en")
                defaultButton = 0
                selectedLanguage = "en"
            }, label: {
                Text("En")
            })
            .focused($defaultButton, equals: 0)
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedLanguage == "en" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            
            Button(action: {
                gvvm.updateLang("sv")
                dlvm.addDefaultLang("sv")
                defaultButton = 2
                selectedLanguage = "sv"
            }, label: {
                Text("Sv")
            })
            .focused($defaultButton, equals: 2)
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedLanguage == "sv" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
        }
        .padding(.trailing, 15)
        .onAppear{
            selectedLanguage = gvvm.currLang
        }
        //setting the value of selectedLanguage
            .onAppear {
                selectedLanguage = gvvm.currLang
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

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageTabView().environmentObject(GlobalVarsViewModel())
    }
}
