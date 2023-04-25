//
//  DetailProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 15.4.2023.
//

import SwiftUI

struct DetailProductView: View {
    
    let data: ProductResponse.Product
    @State var isFavourite = false
    @StateObject private var fvm = FavouritesViewModel()
    @State var id = ""
    
    func allPhoto() -> [String] {
        var pictureArray : [String] = []
        
        if let count: Int = data.productImages?.count {
            for i in 0...count-1 {
                pictureArray.append(data.productImages?[i].originalUrl ?? "")
            }
            return pictureArray
        } else{
            return pictureArray
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
                let _ = print(id, isFavourite)
                // Photos
                PhotoGalaryView(ImagesFile: allPhoto())
                //PhotoGalaryView()
                
                // Information update date
                Text("Information updated on " + dateFormated(data.updatedAt).formatted(date: .abbreviated, time: .shortened))
                    .font(Font.custom("Poppins-LightItalic", size: 14))
                    .frame(width: 370, height: 30, alignment: .topLeading)
                    .padding(.leading, 10)
                
                // pass information like naviation coordinate, phone, website and email
                DetailViewOptions(websiteURL: data.productInformations[0].url ?? "https://www.example.com")
                
                
                // Language selector, Plan the trip, favourite
                DetailViewFeatures(isFavourite: $isFavourite, id: $id)
                
                Spacer(minLength: 50)
                
                // pass all this information to product detail description
                ProductDetailDescription(data: data)
                
                
                DetailViewSocialMedia()
                
            }
        }.onAppear{
            isFavourite = fvm.savedSetting.contains(where: {$0.favouriteId == data.id})
            id = data.id ?? "No value"
        }
        
    }
}

//struct DetailProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProductView()
//    }
//}
