//
//  SideMenuView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI

// A view that displays a side menu with a user's profile information and various other views.
struct SideMenuView: View {
    // The global view model that stores the user's profile information and other globally used variables.
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Displays the user's profile information.
                    ProfileView().frame(height: 300)
                    
                    //Displays the user's home view, a language settings view, and an about us view.
                    CombineView()
                    
                    Spacer()
                }
                .padding(.trailing, 100)
            }
            // Hides the navigation bar of the NavigationView.
            .navigationBarHidden(true)
        }
    }
}

// A view that displays a user's profile information, including their profile image, username, and address.
struct ProfileView: View {
    // The global view model that stores  globally used variables.
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    // The view model that manages the user's profile information.
    @StateObject private var mypvm = MyProfileViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                VStack {
                    // Displays the user's profile image.
                    let defImage = UIImage(named: "profile")!
                    Image(uiImage: gvvm.profileImage ?? defImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 135, height: 135)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color("ThemeColour"), lineWidth: 5)
                        )
                        .padding(.bottom, -5)
                        .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                        .onTapGesture {
                            gvvm.updateShowProfileView(true)
                        }
                    
                    // Displays the user's username.
                    Text(gvvm.userName)
                        .font(.system(size: 24, weight: .semibold))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, -5)
                    
                    // Displays the user's address.
                    Text(gvvm.userAddress)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 24)
                }
                
            }
            Spacer()
            
        }
        // Adds padding to the top of the view.
        .padding(.top, 50)
        // Sets the user's profile information when the view appears.
        .onAppear{
            if(mypvm.savedSetting.last?.my_Image == nil){
                gvvm.profileImage = UIImage(named: "profile")
            }else{
                gvvm.profileImage = UIImage(data: (mypvm.savedSetting.last?.my_Image)!)
                gvvm.userName = mypvm.savedSetting.last?.my_Name ?? "Not Set"
                gvvm.userAddress = mypvm.savedSetting.last?.my_Address ?? "Not Set"
            }
        }
    }
}

//A vertical stack of subviews including ContentView, MyHomeView, LanguageView and AboutUs
struct CombineView: View{
    var body: some View {
        VStack(spacing: 0) {
            // Displays the user's home view.
            ContentView()
                .frame(width: 100, height: 100)
            MyHomeView()
            LanguageView()
            AboutUs()
            Spacer()
            
        }
        .padding(.top, -50)
    }
}

// Displays the home view, including an HStack with an image and text, and a ListAndMap subview.
struct MyHomeView: View {
    // Accesses the GlobalVarsViewModel environment object.
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    var body: some View {
        VStack {
            // HStack with a house icon and text localized based on the current language setting.
            HStack {
                Image(systemName: "house.fill")
                    .frame(width: 26, height: 26)
                    .padding(15)
                
                Text("Default view")
                    .font(Font.custom("Poppins-SemiBold", size: 20))
                //converting app's language to stored default language
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                
                Spacer()
            }
            .padding(.leading, 30)
            // Displays a subview containing a list and map.
            ListAndMap()
                .padding(EdgeInsets(top: -32, leading: 40, bottom: 20, trailing: 0))
                .font(Font.custom("Poppins-Regular", size: 12))
        }
    }
}

// LanguageView is a subview that displays language options.
struct LanguageView: View {
    // Accesses the GlobalVarsViewModel environment object.
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    var body: some View {
        VStack {
            // HStack with an ABC icon and text localized based on the current language setting.
            HStack {
                Image(systemName: "abc")
                    .frame(width: 24, height: 24)
                    .padding(15)
                
                // The title of the language settings view, localized based on the current language setting.
                Text("Language")
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    .font(Font.custom("Poppins-SemiBold", size: 20))
                
                Spacer()
            }
            .padding(.leading, 30)
            
            //converting app's language to stored default language
            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
            
            // A subview that displays language options.
            LanguageOptionView()
                .padding(EdgeInsets(top: -25, leading: 40, bottom: 20, trailing: 0))
                .font(Font.custom("Poppins-Regular", size: 15))
        }
    }
}

// AboutUs displays a button that toggles the "navigateToAboutUsView" when tapped
struct AboutUs: View {
    // Accesses the GlobalVarsViewModel environment object.
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    // State variable that determines if the "About Us" view should be presented.
    @State private var navigateToAboutUsView = false
    
    var body: some View {
        // A button that toggles the "navigateToAboutUsView" when tapped
        Button(action: {
            navigateToAboutUsView = true
        }) {
            // HStack with an info icon and text localized based on the current language setting.
            HStack {
                Image(systemName: "info.circle.fill")
                    .frame(width: 26, height: 26)
                    .padding(15)
                    .foregroundColor(.black)
                Text("About Us")
                    .font(.system(size: 22, weight: .semibold))
                //converting app's language to stored default language
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 28)
            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
        }
        // A full screen cover that presents the "About Us" screen when the "navigateToAboutUsView" is true
        .fullScreenCover(isPresented: $navigateToAboutUsView) {
            NavigationView {
                AboutUsView()
                // A navigation bar button that dismisses the "About Us" screen when tapped
                    .navigationBarItems(leading: Button(action: {
                        navigateToAboutUsView = false
                    }, label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }))
            }
        }
    }
    
    struct SideMenuView_Previews: PreviewProvider {
        static var previews: some View {
            SideMenuView().environmentObject(GlobalVarsViewModel())
        }
    }
}
