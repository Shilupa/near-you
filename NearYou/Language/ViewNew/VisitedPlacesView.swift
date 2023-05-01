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
                VStack(alignment: .leading){
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(pivm.savedSetting.filter({ $0.placeId == place.placeId }), id: \.id) { image in
                                let placeImage = UIImage(data: image.placeImage ?? Data()) ?? UIImage(named: "profile")!
                                Image(uiImage: placeImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    Text(place.address ?? "Not Found")
                    Text(place.city ?? "Not Found")
                    Text(place.postalCode ?? "Not Found")
                    Text(place.eventName ?? "Not Found")
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
