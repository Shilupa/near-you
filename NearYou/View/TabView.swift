//
//  TabView.swift
//  NearYou
//
//  Created by Shilpa Singh on 14.4.2023.
//

import SwiftUI

struct TabView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    var body: some View {
        ListAndMap()
    }
}
struct ListAndMap: View {
    @EnvironmentObject private var lang: LangugageViewModel
    @AppStorage("selectedButton") private var selectedButton: String = "map"
    
    var body: some View {
        HStack {
            Button(action: {
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
                selectedButton = "map"
            }, label: {
                Text("Map")
            })
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == "map" ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
            .environment(\.locale, Locale(identifier: lang.currLang))
        }.padding(.leading, 40)
    }
}

struct LanguageOptionView: View {
    @EnvironmentObject private var lang: LangugageViewModel
    @State private var selectedButton: Int = 0
    @FocusState private var defaultButton: Int?
    
    var body: some View {
        HStack {
            Button(action: {
                lang.updateLang(lang: "fi")
                selectedButton = 1
                defaultButton = 1
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
            }, label: {
                Text("Sv")
            })
            .focused($defaultButton, equals: 2)
            .buttonStyle(RoundedButtonStyle(
                backgroundColor: selectedButton == 2 ? .orange : Color(.systemGray5),
                foregroundColor: .black
            ))
        }.padding(.leading, 40)
    }
}

struct SelectedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct DefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.blue)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
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
        TabView().environmentObject(LangugageViewModel())
    }
}
