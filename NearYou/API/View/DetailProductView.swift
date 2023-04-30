//
//  DetailProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 15.4.2023.
//

import SwiftUI
import CoreLocation
import SimpleToast

struct DetailProductView: View {
    
    let data: ProductResponse.Product
    @State var isFavourite = false
    @State var isPlanned = false
    @StateObject private var fvm = FavouritesViewModel()
    @StateObject private var pvm = PlannedViewModel()
    @State var id = ""
    
    @State private var showCallToast = false
    @State private var showEmailToast = false
    @State var selectedLanguageOption = "en"
    
    private let toastOptions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 2,
        backdrop: Color.black.opacity(0.4),
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true)
    
    
    func allPhoto() -> [String] {
        var pictureArray : [String] = []
        
        if let count: Int = data.productImages?.count {
            for i in 0..<count {
                pictureArray.append(data.productImages?[i].originalUrl ?? "")
            }
            
            return pictureArray
        } else{
            return pictureArray
        }
    }
    
    func allSocialMedia() ->  [[String]]{
        var socialMediaArray : [[String]] = []
        
        if let count: Int = data.socialMedia?.socialMediaLinks.count {
            print("Count:", count)
            for i in 0..<count {
                var item: [String] = []
                item.append(data.socialMedia?.socialMediaLinks[i]?.linkType ?? "")
                item.append(data.socialMedia?.socialMediaLinks[i]?.verifiedLink?.url ?? "")
                socialMediaArray.append(item)
            }
            print("Hahaha: ", socialMediaArray)
            return socialMediaArray
        } else{
            return socialMediaArray
        }
    }
    

    private func dateFormated(_ dateString: String) -> Date {
        let trimmedDateString = dateString.prefix(19)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: String(trimmedDateString))
        return date ?? Date()
    }
    
    
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            ScrollView{
                // Photos
                PhotoGalaryView(ImagesFile: allPhoto())
                //PhotoGalaryView()
                
                // Information update date
                Text("Information updated on " + dateFormated(data.updatedAt).formatted(date: .abbreviated, time: .shortened))
                    .font(Font.custom("Poppins-LightItalic", size: 14))
                    .frame(width: 370, height: 30, alignment: .topLeading)
                    .padding(.leading, 10)
                
                // pass information like naviation coordinate, phone, website and email
                let trimmedCoordinates = data.postalAddresses?[0].location?.trimmingCharacters(in: CharacterSet(charactersIn: "()")) ?? ""
                let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
                let coordinate = CLLocationCoordinate2D(latitude: Double(coordinateComponents[0]) ?? 0.0, longitude: Double(coordinateComponents[1]) ?? 0.0)
               
                DetailViewOptions(websiteURL: data.productInformations?[0].url ?? "https://www.example.com",destination: coordinate, data: data, selectedOption: "nice", showCallToast: $showCallToast, showEmailToast: $showEmailToast, selectedLanguageOption : $selectedLanguageOption)
                
                Spacer(minLength: 30)
                // Language selector, Plan the trip, favourite
                DetailViewFeatures(isFavourite: $isFavourite, id: $id, isPlanned: $isPlanned)
                
                Spacer(minLength: 30)
                
                // pass all this information to product detail description
                ProductDetailDescription(data: data, selectedLanguageOption: $selectedLanguageOption)
                
                //let _ = allSocialMedia()
                
                DetailViewSocialMedia(socialMediaList: allSocialMedia())
                
            }
        }.onAppear{
            id = data.id ?? "No value"
            isFavourite = fvm.savedSetting.contains(where: {$0.favouriteId == data.id})
            isPlanned = pvm.savedSetting.contains(where: {$0.plannedId == data.id})
        }.simpleToast(isPresented: $showCallToast, options: toastOptions){
            Text("Call functionality is disabled in simulator")
                .bold()
                .padding()
                .foregroundColor(.white)
                .background(Color("ThemeColour").opacity(0.8))
                .cornerRadius(10)
        }.simpleToast(isPresented: $showEmailToast, options: toastOptions){
            Text("Email functionality is disabled in simulator")
                .bold()
                .padding()
                .foregroundColor(.white)
                .background(Color("ThemeColour").opacity(0.8))
                .cornerRadius(10)
        }
        
    }
}

//struct DetailProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProductView()
//    }
//}
