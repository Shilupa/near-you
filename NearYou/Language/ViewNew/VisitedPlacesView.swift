//
//  VisitedPlaces.swift
//  NearYou
//
//  Created by Shilpa Singh on 1.5.2023.
//

import SwiftUI

struct VisitedPlacesView: View {
    @StateObject private var vvm = VisitedViewModel()
    @StateObject private var pivm = PlaceImageViewModel()
    
    var body: some View {
        List{
            ForEach(vvm.savedSetting, id: \.self) { place in
                VStack{
                    Text(place.address ?? "Not Found")
                    Text(place.city ?? "Not Found")
                    Text(place.postalCode ?? "Not Found")
                    Text(place.eventName ?? "Not Found")
                    ForEach(pivm.savedSetting.filter({ $0.placeId == place.placeId }), id: \.id) { image in
                        let placeImage = UIImage(data: image.placeImage ?? Data()) ?? UIImage(named: "profile")!
                        VStack{
                            Image(uiImage: placeImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
        }
    }
}

struct VisitedPlaces_Previews: PreviewProvider {
    static var previews: some View {
        VisitedPlacesView()
    }
}
