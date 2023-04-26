//
//  SideMenuView.swift
//  NearYou
//
//  Created by Shilpa Singh on 3.4.2023.
//

import SwiftUI
import CoreLocation


// Sample for add padding to all direction in Vstack
// To be deleted later
// VStack{
//    bla bla bla
// }.padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))

struct SideMenuView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "FBF2B8"), Color(hex: "FACFD9")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    ProfileView().frame(height: 300)
                    
                    CombineView()
                    
                    
                    
                    Spacer()
                }
                .padding(.trailing, 100)
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    @StateObject private var mypvm = MyProfileViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                VStack {
                    let defImage = UIImage(named: "profile")!
                    Image(uiImage: gvvm.profileImage ?? defImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 135, height: 135)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.orange, lineWidth: 3)
                        )
                        .padding(.bottom, 16)
                        .onTapGesture {
                            gvvm.updateShowProfileView(true)
                        }
                    
                    Text(gvvm.userName)
                        .font(.system(size: 24, weight: .semibold))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 8)
                    
                    Text(gvvm.userAddress)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 24)
                }
                
            }
            Spacer()
        }
        .padding(.top, 50)
        // When view is loaded these values are set
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

struct CombineView: View{
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack(spacing: 0) {
            MyHomeView()
            LanguageView()
            AboutUsView()
            ContentView()
            
//            if let location = locationManager.location {
//                if let weather = weather {
//                    WeatherView(weather: weather)
//                } else {
//                    LoadingView()
//                        .task {
//                            do {
//                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
//                            } catch {
//                                print("Error getting weather: \(error)")
//                            }
//                        }
//                }
//                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
//            }
////            else {
////                if locationManager.isLoading {
////                    ProgressView()
////                } else {
////                    WelcomeView()
////                    .environmentObject(locationManager)
////
////                }
////            }
        }
    }
}

struct MyHomeView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "house.fill")
                    .frame(width: 26, height: 26)
                    .padding(15)
                
                Text("Default view")
                    .font(.system(size: 22, weight: .semibold))
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                
                Spacer()
            }
            .padding(.leading, 30)
            ListAndMap()
        }
    }
}

struct LanguageView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "abc")
                    .frame(width: 24, height: 24)
                    .padding(15)
                
                Text("Language")
                    .font(.system(size: 22, weight: .semibold))
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                
                Spacer()
            }
            .padding(.leading, 30)
            
            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
            
            LanguageOptionView()
        }
    }
}

struct AboutUsView: View {
    @EnvironmentObject private var gvvm: GlobalVarsViewModel
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "info.circle.fill")
                    .frame(width:26, height:26)
                    .padding(15)
                Text("About Us")
                    .font(.system(size: 22, weight: .semibold))
                    .environment(\.locale, Locale.init(identifier: gvvm.currLang))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 28)
            .environment(\.locale, Locale.init(identifier: gvvm.currLang))
            .padding(.bottom)
            Text("Weather at current location:")
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView().environmentObject(GlobalVarsViewModel())
    }
}
