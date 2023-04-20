//
//  UserModel.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import Foundation


struct ProductResponse: Codable {
    let data: DataClass
    
    
    struct DataClass: Codable {
        let product: [Product]
    }
    
    struct Product: Codable {
        let id, type, duration, durationType: String?
        let company: Company?
        let postalAddresses: [PostalAddress]?
        let productAvailableMonths: [ProductAvailableMonth]?
        let productInformations: [ProductInformation]
        let productImages: [ProductImage]?
        let productPricings: [ProductPricing]
        let accessible: Bool?
        let contactDetails: [ContactDetail]
        let productAvailabilities: [ProductAvailability]
        let productCapacities: [ProductCapacities]
        let updatedAt: String
        let businessHours: BusinessHours
        let productAvailabilityLanguages: [ProductAvailabilityLanguages?]
        let socialMedia: SocialMedia?
    }
    
    struct Company: Codable {
        let businessName: String?
    }
    
    struct PostalAddress: Codable {
        let location: String?
        let postalCode: String?
        let streetName: String?
        let city: String?
    }
    
    //Sebastian - I need this to pass the coordinates to the weather icon
    struct Location {
        var latitude: Double?
        var longitude: Double?
    }
    //Sebastian - I need this to pass the coordinates to the weather icon
    
    struct ProductAvailableMonth: Codable {
        let month: String?
    }
    
    struct ProductInformation: Codable {
        let description, language, name: String?
        let url: String?
        let webshopUrl: String?
    }
    
    struct ProductImage: Codable {
        let filename, altText: String?
        let largeUrl, originalUrl, thumbnailUrl: String?
    }
    
    struct ProductPricing: Codable {
        let toPrice, fromPrice: Double?
        let pricingUnit: String?
        let pricingType: String?
    }
    
    struct ContactDetail: Codable {
        let email, phone: String?
    }
    
    
    struct ProductAvailability: Codable {
        let endDate, startDate: String?
    }
    
    
    struct ProductCapacities: Codable {
        let max: Int?
        let min: Int?
    }
    
    
    struct BusinessHours: Codable {
        let businessHoursDefault: [Default]
        
        enum CodingKeys: String, CodingKey {
            case businessHoursDefault = "default"
        }
        
        struct Default: Codable {
            let closes: String?
            let open: Bool?
            let opens: String?
            let weekday: String?
        }
    }
    
    
    struct ProductAvailabilityLanguages: Codable {
        let language: String?
    }
    
    
    struct SocialMedia: Codable {
        let socialMediaLinks: [SocialMediaLink?]
        
        struct SocialMediaLink: Codable {
            let linkType: String?
            let verifiedLink: VerifiedLink?
            
            struct VerifiedLink: Codable {
                let url: String?
            }
            
        }
    }
}

//struct Location: Codable {
//    var location: String
//    var postalCode: String
//    var streetName: String
//    var city: String
//}

struct Location {
    let latitude: Double
    let longitude: Double
}
