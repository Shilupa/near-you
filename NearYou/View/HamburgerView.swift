//
//  HamburgerView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 6.4.2023.
//

//import SwiftUI
//
//struct HamburgerView: View {
//    @State private var isShowing = false
//    var body: some View {
//
//
//        NavigationView{
//
//            ZStack {
//                if isShowing {
//                    SideMenuView(isShowing: $isShowing)
//                }
//
//                HomeView()
//                    .cornerRadius(isShowing ? 20 : 10)
//                    .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
//                    .scaleEffect(isShowing ? 0.8 : 1)
//                    .navigationBarItems(leading: Button(action: {
//                        withAnimation(.spring()) {
//                            isShowing.toggle()
//                        }
//                    }, label: {
//                        Image(systemName: "list.bullet")
//                            .foregroundColor(.black)
//                    }))
//            }
//            .onAppear{
//                isShowing = true
//            }
//
//
//        }
//
//
//
//
//
//    }
//}
//
//struct HamburgerView_Previews: PreviewProvider {
//    static var previews: some View {
//        HamburgerView().environmentObject(LangugageViewModel())
//    }
//}
//
//
