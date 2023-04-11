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

/*
var A = {"data": {
        "product": [
            {
                "id": "f6252da7-0994-4c23-b338-cbb380126c36",
                "productInformations": [
                    {
                        "description": "UNITY. For tomorrow's professionals. \n\nModern studio apartments and workspaces for efficient work and better life. Stay for a day, a month, or a year.",
                        "language": "en",
                        "name": "UNITY Helsinki Studio Apartments & Coworking"
                    },
                    {
                        "description": "UNITY. Uusi elämäntapa tulevaisuuden ammattilaisille.\n\nModerneja studio- ja loft-huoneistoja ja työtiloja, jotka tehostavat työskentelyä ja parantavat elämää. Viivy päivä, kuukausi tai vuosi.",
                        "language": "fi",
                        "name": "UNITY Helsinki -studiohuoneistot & coworking-tilat"
                    }
                ]
            },
            {
                "id": "b3142faa-f31f-4416-8a56-c04f97e7f352",
                "productInformations": [
                    {
                        "description": "Lunch is served daily in our restaurant on weekdays from 10.30-14.00.\nAt lunch, your choice of main course is prepared as a dish and always includes salads, soup, bread and coffee from the takeaway table.\n\nOn the café side, you can choose from breakfast, speciality coffees, savoury and sweet dishes.\n\nStop by for a coffee or even a glass of prosecco!",
                        "language": "en",
                        "name": "Snygg - Restaurant & Café"
                    },
                    {
                        "description": "Ravintolassamme on päivittäin tarjolla lounas arkisin klo 10.30-14. \nLounaalla valitsemasi pääruoka valmistetaan lautasannoksena ja sisältää aina salaatit, keiton, leivän ja kahvin noutopöydästä\n\nKahvilan puolella valikoimassa mm. aamupalaa, erikoiskahveja, suolaista ja makeaa.\n\nPiipahda kahville tai vaikka lasilliselle proseccoa!",
                        "language": "fi",
                        "name": "Snygg - Restaurant & Café"
                    }
                ]
            },
            {
                "id": "d75230b2-536f-4605-a3b2-7bddc048227b",
                "productInformations": [
                    {
                        "description": "Join the beginners’ course to learn the basic paddling skills and techniques at the Vuosaari Paddling Center and explore the beautiful nature of Helsinki. No prior experience is needed and it is not overly strenuous! The course takes place on Tuesday-, Wednesday- and Thursday evenings between 18 and 21.30. Please check the dates and availability from the booking calendar.\n\nThe price includes a professional instructor, a kayak, a paddle, a sprayskirt and a PFD as well as a free 2-hour kayak rental after the course. Please notice that the participant must be at least 16 years old. \n\nPeaceful moments in nature are waiting - Book your place on the course!",
                        "language": "en",
                        "name": "Beginners' course in kayaking"
                    }
                ]
            }]}}
*/
