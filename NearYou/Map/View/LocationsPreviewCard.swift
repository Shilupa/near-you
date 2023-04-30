//
//  LocationsPreviewCard.swift
//  NearYou
//
//  Created by Bibek on 29.4.2023.
//

import SwiftUI

struct LocationsPreviewCard: View {
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
        
        HStack (alignment: .bottom, spacing: 0){
            VStack(alignment: .leading, spacing: 16){
                imageSection
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
            }
            
            VStack(spacing: 8){
                titleSection
                WeatherWithAPICoordinates(data: data)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}


extension LocationsPreviewCard {
    private var imageSection : some View {
        ZStack{
            let url = URL(string:data.productImages?[0].thumbnailUrl ?? "http://placekitten.com/g/200/300" )
            AsyncImage(url: url) { Image in
                Image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            } placeholder: {
                
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection : some View {
        VStack(alignment: .leading, spacing: 4){
            Text(data.productInformations?[0].name ?? "")
                .fontWeight(.bold)
                .font(.title3)
                .lineLimit(1)
                .font(Font.custom("Poppins-Regular", size: 12))
            Text(data.postalAddresses![0].streetName ?? "")
                .font(.subheadline)
                .font(Font.custom("Poppins-Regular", size: 12))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var previousButton :some View {
        Button {
            
        } label: {
            Text("Previous")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton : some View {
        Button {
            
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
   
}
