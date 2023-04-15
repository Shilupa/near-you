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
        VStack{
            ListAndMap()
            LanguageOptionView()
        }
    }
}

struct ListAndMap: View {
    @EnvironmentObject private var lang: LangugageViewModel
    @AppStorage("selectedButton") private var selectedButton: String = "map"
    var rightButtonText: String? = nil
    var leftButtonText: String? = nil
    var rightButtonAction: () -> Void = {}
    var leftButtonAction: () -> Void = {}
    @State private var isLeftButtonSelected: Bool = false
    @State private var isRightButtonSelected: Bool = false
    
    init() {
        _isLeftButtonSelected = State(initialValue: false)
        _isRightButtonSelected = State(initialValue: true)
    }
    
    var body: some View {
        HStack {
            Button(action: {
                leftButtonAction()
                isLeftButtonSelected = true
                isRightButtonSelected = false
                selectedButton = "list"
            }) {
                Text("List")
                    .padding()
                    .font(.system(size: 13))
                    .foregroundColor(isLeftButtonSelected ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 63)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(isLeftButtonSelected ? Color.orange : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                        //.stroke(Color.orange, lineWidth: isLeftButtonSelected ? 0 : 1)
                            .stroke(Color.clear, lineWidth: 0)
                    ).environment(\.locale, Locale.init(identifier: lang.currLang))
                //.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
            }
            
            Button(action: {
                rightButtonAction()
                isLeftButtonSelected = false
                isRightButtonSelected = true
                selectedButton = "map"
            }) {
                Text("Map")
                    .padding()
                    .font(.system(size: 13))
                    .foregroundColor(isRightButtonSelected ? .white : .black)
                    .frame(minWidth: 0, maxWidth: 70)
                    .frame(minHeight: 0, maxHeight: 25)
                    .background(isRightButtonSelected ? Color.orange : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.clear, lineWidth: 0) // remove the border color
                    )
                    .environment(\.locale, Locale.init(identifier: lang.currLang))
                //.padding(EdgeInsets(top: 5, leading: 12, bottom: 5, trailing: 0))
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
        }.padding(.trailing, 15)
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
