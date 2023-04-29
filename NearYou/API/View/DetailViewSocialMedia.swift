//
//  DetailViewSocialMedia.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 18.4.2023.
//

import SwiftUI



struct DetailViewSocialMedia: View {
    
    let socialMediaList: [[String]]
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            if socialMediaList.count == 0 {
                Text("No social media available.")
                    .padding(.leading)
            } else{
                HStack{
                    ForEach(socialMediaList, id: \.self){ item in
                        Link(destination: URL(string: item[1])!, label: {
                            Image(item[0])
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

//struct DetailViewSocialMedia_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewSocialMedia()
//    }
//}
