//
//  UserModel.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let name: String
    let company: Company
}

struct Company: Codable {
    let name: String
}

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

struct SampleData: Codable {
    let id: String
    let productInformations: [ProductInformation]
}

struct ProductInformation: Codable, Hashable {
    let description: String
    let language: String
    let name: String
}
