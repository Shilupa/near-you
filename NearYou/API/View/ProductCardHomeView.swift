//
//  ProductView.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import SwiftUI

struct ProductCardHomeView: View {
    
    let data: ProductResponse.Product
    
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
                Text(data.productInformations[0].name ?? "")
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
                
                
                // Opening Hours
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
                                .foregroundColor(Color(.green))
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
                        Text("2 km away")
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Regular", size: 12))
                        
                        Text("from your location")
                            .lineLimit(1)
                            .font(Font.custom("Poppins-Regular", size: 12))
                    }
                    
                    Spacer()
                    
                    
                    // Sebastian will work on this part of UI
                    WeatherWithAPICoordinates(data: data)
                }
                

                
            }}
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(5)
        .background(Color("CardBackground"))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
        .shadow(color: Color("ThemeColour").opacity(0.1), radius: 5)

    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello Product Card Home View ")
    }
}
