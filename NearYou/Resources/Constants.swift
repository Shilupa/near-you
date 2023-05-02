//
//  Constants.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 8.4.2023.
//

import Foundation


let graphQLQuery = """
    query ProductsInHelsinki {
        product(where: {postalAddresses: {postalArea: { city: { city: {_eq: "Helsinki"} }}}}) {
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


