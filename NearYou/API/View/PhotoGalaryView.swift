//
//  PhotoGalaryView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 17.4.2023.
//

import SwiftUI

struct PhotoGalaryView: View {
    
    private let ImagesFile = ["https://cdn-datahub.visitfinland.com/images/e149cdb0-67d8-11ec-91fb-3b444fc9a7da-Hel%20picture2.JPG", "https://cdn-datahub.visitfinland.com/images/dd560c70-5434-11ed-ae94-05cf802d2c37.jpeg","https://cdn-datahub.visitfinland.com/images/df168120-5434-11ed-ae94-05cf802d2c37.jpeg","https://cdn-datahub.visitfinland.com/images/e05d5900-5434-11ed-ae94-05cf802d2c37.jpeg","https://cdn-datahub.visitfinland.com/images/e15bdd40-5434-11ed-ae94-05cf802d2c37.jpeg","https://cdn-datahub.visitfinland.com/images/e2b10d00-5434-11ed-ae94-05cf802d2c37.jpeg"]
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    @State private var currentIndex = 0
    
    var body: some View {
        
        GeometryReader{ proxy in
            
            TabView (selection: $currentIndex) {
                ForEach(0..<5){ count in
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
            }.tabViewStyle(PageTabViewStyle())
                .onReceive(timer, perform: {_ in
                    withAnimation{currentIndex = currentIndex < 5 ? currentIndex + 1 : 0}})
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(5)
                .frame(width: proxy.size.width, height: 250)
        }
    }
}

struct PhotoGalaryView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGalaryView()
    }
}
