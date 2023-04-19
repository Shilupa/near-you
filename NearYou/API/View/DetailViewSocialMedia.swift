//
//  DetailViewSocialMedia.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI


func goSocialMedia () {
    
}

private let socialMediaList: [String] = ["facebook","instagram","linkedin"]



struct DetailViewSocialMedia: View {
    var body: some View {
        
        VStack(alignment: .leading){
            
            if socialMediaList.count == 0 {
                Text("No social media available.")
                    .padding(.leading)
            } else{
                
                Text("Social media")
                    .bold()
                    .padding(.leading)
                
                HStack{
                    ForEach(socialMediaList, id: \.self){ item in
                        
                        Link(destination: URL(string: "https://www.facebook.com/profile.php?id=100083195533791")!, label: {
                            
                            Image(item)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .shadow(color: Color.gray, radius: 7, x: 0, y: 2)
                                .padding(10)
                            
                        })
                    }
                }
            }
        }
    }
}

struct DetailViewSocialMedia_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewSocialMedia()
    }
}
