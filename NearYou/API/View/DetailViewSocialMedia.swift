//
//  DetailViewSocialMedia.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI


//func goSocialMedia () {
//
//}

// private let socialMediaList: [String] = ["facebook","instagram","linkedin"]



struct DetailViewSocialMedia: View {
    
    let data: ProductResponse.Product
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            HStack{
                
                if let socialMediaData: ProductResponse.SocialMedia = data.socialMedia {
                    
                    ForEach(socialMediaData.socialMediaLinks, id: \.self) { item in
                        
                        let url = item?.verifiedLink
                        
                        Link(destination: URL(string: url))!, label: {
                            
                            Image(item.linkType ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                                .padding(10)
                            
                        }
                        
                    }
                } else {
                    Text("No social media available.")
                        .padding(.leading)
                }
                
                
            }
            
            
        }
    }
}

//struct DetailViewSocialMedia_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewSocialMedia()
//    }
//}
