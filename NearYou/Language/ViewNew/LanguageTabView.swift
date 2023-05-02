//
//  TabView.swift
//  NearYou
//
//  Created by Shilpa Singh on 14.4.2023.
//

import SwiftUI

// This is a view that displays language options
struct LanguageTabView: View {
    // Accesses the global language variable
    @EnvironmentObject private var lang: GlobalVarsViewModel
    var body: some View {
        VStack{
            LanguageOptionView()
        }
    }
}

// This is a view that displays a button to toggle between list and map views
struct ListAndMap: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    @StateObject private var dvm = DefaultViewModel()
    
    var body: some View {
        HStack {
            // Button to display list view
            Button(action: {
                // Sets list as default view
                dvm.addDefaultView(0)
            }) {
                Text("List")
                    .padding()
                    .foregroundColor(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 0 ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 63)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 0 ? Color("ThemeColour") : Color.gray.opacity(0.5))
                    .buttonStyle(CustomButtonStyle())
                //converting app's language to stored default language
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
            }
            
            // Button to display map view
            Button(action: {
                // Sets Map as default view
                dvm.addDefaultView(1)
            }) {
                Text("Map")
                    .padding()
                    .foregroundColor(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 1 ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 70)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(Int(dvm.savedSetting.last?.listOrMap ?? 0) == 1 ? Color("ThemeColour") : Color.gray.opacity(0.5))
                    .buttonStyle(CustomButtonStyle())
                //converting app's language to stored default language
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
            }
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        .mask {
            // A mask to apply rounded corners to the view
            RoundedRectangle(cornerRadius: 25)
        }
    }
}

// A custom button style that applies rounded corners and a stroke to the button
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("ThemeColour"), lineWidth: configuration.isPressed ? 3 : 1)
            )
            .contentShape(RoundedRectangle(cornerRadius: 25))
    }
}

// This is a view that displays language options as buttons
struct LanguageOptionView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    @FocusState private var defaultButton: Int?
    @State private var selectedLanguage = "en"
    @StateObject private var dvm = DefaultViewModel()
    @StateObject private var dlvm = DefaultLangViewModel()
    
    var body: some View {
        
        HStack {
            // Button for Finnish language
            Button(action: {
                // Updates the language and default language settings
                gvvm.updateLang("fi")
                dlvm.addDefaultLang("fi")
                defaultButton = 1
                selectedLanguage = "fi"
            }, label: {
                Text("Fi")
            })
            // Focused state for this button is set to 1 when it is focused
            .focused($defaultButton, equals: 1)
            
            // Styling of the RoundedButton
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedLanguage == "fi" ? Color("ThemeColour") : Color(.systemGray5),
                foregroundColor: .black
            ))
            // Default language button for english language
            Button(action: {
                // Updates the language and default language settings to English
                gvvm.updateLang("en")
                dlvm.addDefaultLang("en")
                defaultButton = 0
                selectedLanguage = "en"
            }, label: {
                Text("En")
            })
            // Focused state for this button is set to 0 when it is focused
            .focused($defaultButton, equals: 0)
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedLanguage == "en" ? Color("ThemeColour") : Color(.systemGray5),
                foregroundColor: .black
            ))
            
            // Button for Swedish language
            Button(action: {
                // Updates the language and default language settings to Swedish
                gvvm.updateLang("sv")
                dlvm.addDefaultLang("sv")
                defaultButton = 2
                selectedLanguage = "sv"
            }, label: {
                Text("Sv")
            })
            // Focused state for this button is set to 2 when it is focused
            .focused($defaultButton, equals: 2)
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedLanguage == "sv" ? Color("ThemeColour") : Color(.systemGray5),
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

// Button style with rounded corners and a border
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
                        .stroke(Color("ThemeColour"), lineWidth: 2)
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
