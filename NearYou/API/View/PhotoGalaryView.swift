//
//  PhotoGalaryView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 17.4.2023.
//

import SwiftUI

struct PhotoGalaryView: View {
    
    var ImagesFile: [String]

    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State private var currentIndex = 0
    
    
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                TabView (selection: $currentIndex) {
                    
                    
                    ForEach(0..<ImagesFile.count){ count in
                        let url = URL(string: ImagesFile[count] )
                        AsyncImage(url: url) { Image in
                            Image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {

                            ProgressView()
                                .frame(width: 120, height: 100)
                        }
                    }
                    
                    
                    
                    
//                    ForEach(ImagesFile, id: \.self ){ urlName in
//                        let url = URL(string: urlName )
//                        AsyncImage(url: url) { Image in
//                            Image
//                                .resizable()
//                                .scaledToFill()
//                        } placeholder: {
//
//                            ProgressView()
//                                .frame(width: 120, height: 100)
//                        }
//                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .onReceive(timer, perform: {_ in
                    withAnimation{
                        currentIndex = currentIndex < ImagesFile.count ? currentIndex + 1 : 0
                    }})
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(5)
                .frame(width: proxy.size.width, height: 250)
            }
            Spacer(minLength: 250)
        }
    }
}

//struct PhotoGalaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoGalaryView()
//    }
//}
