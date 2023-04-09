//
//  Constants.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 8.4.2023.
//

import Foundation


let sampleGraphQLQuery = """
query AllProducts {


  product(where: {postalAddresses: {postalArea: { city: { city: {_eq: "Vantaa"} }}}}) {
id
productInformations {
  description
  language
  name
}}}
"""

/*

struct SampleResponse: Codable {
    let data: Data
      
    struct Data: Codable {
        let product: [Product]
    }
    
    struct Product: Codable {
        let id: String
        let productInformations: [ProductInformation]
    }
    
    struct ProductInformation: Codable, Hashable {
        // let description: String
        let language: String
        let name: String
    }

}
 */





let graphQLQuery = """
    query ProductsInHelsinki {
        product(where: {postalAddresses: {postalArea: { city: { city: {_eq: "Vantaa"} }}}}) {
        id
        type
        duration
        durationType
        company {
         businessName
    }
    postalAddresses {
      location
      postalCode
      streetName
      city
    }
    productAvailableMonths {
    month }
    productInformations {
      description
      language
      name
    url
    webshopUrl }
    productImages {
      copyright
      filename
      altText
      largeUrl
      originalUrl
      thumbnailUrl
      coverPhoto
      orientation
      originalWidth
      originalHeight
    }
    productPricings {
      toPrice
      fromPrice
      pricingUnit
      pricingType
    }
    accessible
    contactDetails {
    email
    phone }
    productAvailabilities {
      endDate
    startDate }
    productCapacities {
      max
    min }

        updatedAt
        businessHours {
          default {
            closes
            open
            opens
            weekday
          }
          exceptions {
            start
            end
            openingHours {
              closes
              date
              open
              opens
              weekday
    } }
        }
        productAvailabilityLanguages {
    language }
            socialMedia {
          socialMediaLinks {
            linkType
            verifiedLink {
    url }
    } }
    } }

"""





// token response struct class to extract token data
struct ProductData: Codable {
    let data: Data
    
    struct Data: Codable {
        let product: [Product]
        
        struct Product: Codable {
            let id: String
            let type: String
            let duration: String
            let durationType: String
            let company: Company
            let postalAddresses: [PostalAddress]
            let productAvailableMonths: [ProductAvailableMonth]
            let productInformations: [ProductInformation]
            let productImages: [ProductImage]
            let productPricings: [ProductPricings]
            let accessible: Bool
            let contactDetails: [ContactDetails]
            let productAvailabilities: [ProductAvailabilities]
            let productCapacities: [ProductCapacities]
            let updatedAt: String
            let businessHours: BusinessHours
            let productAvailabilityLanguages: [String]
            let socialMedia: SocialMedia
            

            struct Company: Codable {
                let businessName: String
            }
            
            struct PostalAddress: Codable {
                let location: String
                let postalCode: String
                let streetName: String
                let city: String
            }
            
            struct ProductAvailableMonth: Codable {
                let month: String
            }
            
            struct ProductInformation: Codable {
                let description: String
                let language: String
                let name: String
                let url: String
                let webshopUrl: String
            }
            
            struct ProductImage: Codable {
                let copyright: String
                let filename: String
                let altText: String
                let largeUrl: String
                let originalUrl: String
                let thumbnailUrl: String
                let coverPhoto: Bool
                let orientation: String
                let originalWidth: Int
                let originalHeight: Int
            }
            
            struct ProductPricings: Codable{
                let toPrice: Double
                let fromPrice: Double
                let pricingUnit: String
                let pricingType: String
            }
            
            struct ContactDetails: Codable{
                let email: String
                let phone: String
            }
            
            struct ProductAvailabilities: Codable{
                let endDate: Date?
                let startDate: Date?
            }
            
            struct ProductCapacities: Codable{
                let max: Int
                let min: Int
            }
            
            struct BusinessHours: Codable {
                let `default`: [BusinessDay]
                let exceptions: [ExceptionDay]
                
                struct BusinessDay: Codable {
                    let closes: String?
                    let open: Bool
                    let opens: String?
                    let weekday: String
                }
                
                struct ExceptionDay: Codable {
                    // define properties here for exceptional days
                }
            }
            
            struct SocialMedia: Codable {
                let socialMediaLinks: [SocialMediaLink]
                
                struct SocialMediaLink: Codable {
                    let linkType: String
                    let verifiedLink: VerifiedLink
                    
                    struct VerifiedLink: Codable {
                        let url: String
                    }
                }
            }
        }
    }
}
