//
//  ProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import SwiftUI
import CoreLocation

/*
 Design of each card view used throughout the app
 */
struct ProductCardHomeView: View {
    @StateObject private var fvm = FavouritesViewModel()
    let data: ProductResponse.Product
    @EnvironmentObject  var viewModel : MapViewModel

    func weekdayName(from weekday: Int) -> String {
        switch weekday {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
    
    func isProductOpen(openTime: String, closeTime: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let open: Date = dateFormatter.date(from: openTime) ??
        dateFormatter.date(from: "00:00:00")!
        
        let close: Date = dateFormatter.date(from: closeTime) ?? dateFormatter.date(from: "00:00:00")!
        
        let currentTime = Date()
        let current = dateFormatter.string(from: currentTime)
        let now = dateFormatter.date (from: current)
        
        
        if now?.compare(open) == .orderedDescending && close.compare(now!) == .orderedDescending{
            return "Open"
        } else {
            return "Closed"
        }
    }
    
    var body: some View {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: currentDate)
        
        let url = URL(string:data.productImages?[0].thumbnailUrl ?? "http://placekitten.com/g/200/300" )
        
        HStack {
            
            AsyncImage(url: url) { Image in
                Image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 100)
                    .cornerRadius(10)
            } placeholder: {
                
                ProgressView()
                    .frame(width: 120, height: 100)
            }
            
            VStack(alignment: .leading){
                
                // Title of the product
                Text(data.productInformations?[0].name ?? "")
                    .lineLimit(1)
                    .font(Font.custom("Poppins-Regular", size: 18))
                    .shadow(radius: 0.5)
                
                // Address of the product
                HStack{
                    Text(data.postalAddresses![0].streetName ?? "")
                        .font(Font.custom("Poppins-Regular", size: 12))
                    Text(data.postalAddresses![0].city ?? "")
                        .font(Font.custom("Poppins-Regular", size: 12))
                }
            
                // Business Hours
                HStack{
                    Text("Opening:")
                        .font(Font.custom("Poppins-SemiBold", size: 12))
                        
                    let todayWeek: String = weekdayName(from: weekday)
                    
                    let today = data.businessHours.businessHoursDefault.filter{$0.weekday == todayWeek.lowercased()}
                        
                    if today[0].opens == nil || today[0].closes == nil {
                        Text("Unknown")
                            .font(Font.custom("Poppins-Regular", size: 12))
                            .foregroundColor(Color("ThemeColour"))
                    } else {
                        let openHours:String = today[0].opens!
                        let openHour = openHours.prefix(openHours.count - 3)
                        
                        let closeHours:String = today[0].closes!
                        let closeHour = closeHours.prefix(closeHours.count - 3)
                        
                        let isopen = isProductOpen(openTime: openHours, closeTime: closeHours )
                        
                        Text(openHour + "-" + closeHour)
                            .font(.caption)
                        
                        if isopen == "Open" {
                            Text(isopen)
                                .font(Font.custom("Poppins-Regular", size: 12))
                                .foregroundColor(Color(.systemGreen))
                                .bold()
                        }else {
                            Text(isopen)
                                .font(Font.custom("Poppins-Regular", size: 12))
                                .foregroundColor(Color(.red))
                                .bold()
                        }
                    }
                }
                
                HStack{
                    
                    VStack (alignment: .leading){
                        let trimmedCoordinates = data.postalAddresses![0].location!
                            .trimmingCharacters(in: CharacterSet(charactersIn: "()"))
                        
                        let coordinateComponents = trimmedCoordinates.components(separatedBy: ",")
                        let coordinate = CLLocationCoordinate2D(latitude: Double(coordinateComponents[0]) ?? 0.0, longitude: Double(coordinateComponents[1]) ?? 0.0)
                        let distanceInMeters = viewModel.locationManager.location?.distance(from: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
                        let distanceInKm = (distanceInMeters ?? 0.0) / 1000

                        Text(String(round(distanceInKm * 100) / 100) + "km away")
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Regular", size: 12))
                        
                        Text("from your location")
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Regular", size: 12))
                    }
                    Spacer()
                    WeatherWithAPICoordinates(data: data)
                }
            }}
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(5)
        .background(Color("CardBackground"))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
        .shadow(color: Color("ThemeColour").opacity(0.1), radius: 5)
        .onAppear{
            fvm.fetchSettings()
        }

    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello Product Card Home View ")
    }
}
