//
//  DetailProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 15.4.2023.
//

import SwiftUI
import CoreLocation

struct DetailProductView: View {
    
    let data: ProductResponse.Product
    
    
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
               
                DetailViewOptions(websiteURL: data.productInformations[0].url ?? "https://www.example.com",destination: coordinate, selectedOption: "nice")
                
                
                // Language selector, Plan the trip, favourite
                DetailViewFeatures()
                
                Spacer(minLength: 50)
                
                // pass all this information to product detail description
                ProductDetailDescription(data: data)
                

                DetailViewSocialMedia()
                
            }
            
            
            
            
        }
        
    }
}

//struct DetailProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailProductView()
//    }
//}
