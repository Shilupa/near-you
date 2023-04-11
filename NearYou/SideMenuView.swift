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
                    HStack(spacing: 16) {
                        Image(systemName: option.imageName)
                            .frame(width:24, height:24)
                            .padding(15)
                        let _ = print(type(of: option.title))
                        Text(option.title)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                            .environment(\.locale, Locale(identifier: lang.currLang))
                        Spacer()
                    }
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
            // Default langugae
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
        }
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

struct HomView: View {
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
        }
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true)).environmentObject(LangugageViewModel())
    }
}
