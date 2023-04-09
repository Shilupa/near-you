//
//  NearYouApp.swift
//  NearYou
//
//  Created by Shilpa Singh on 2.4.2023.
//

import SwiftUI
import CoreData

@main

struct NearYouApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

/*

struct NearYouApp: App {
    
    // create persistance controller
    
    let persistenceController = PersistenceController.shared
    
    init() {
        // updateDataFromNetwork(context: persistenceController.container.viewContext)
        getToken()
    }
    
    private let client_id = "datahub-api"
    private let client_secret = "ed7cd94f-727e-4cf7-879c-1c26f798bcc0"
    private let grant_type = "password"
    private let username = "bibek.shrestha@metropolia.fi"
    private let password = "Hello404Datahub!"
    
    //func updateDataFromNetwork(context: NSManagedObjectContext) {
    
    func getToken() {
        
        // token response struct class to extract token data
        struct TokenResponse: Codable{
            let access_token: String
        }
        
        // Get the URL for bearer token
        guard let tokenUrl = URL(string: "https://iam-datahub.visitfinland.com/auth/realms/Datahub/protocol/openid-connect/token") else {
            print("Bad Url")
            return}
        
        // Setting token Request
        var tokenRequest = URLRequest(url: tokenUrl)
        tokenRequest.httpMethod = "POST"
        let parameters = "client_id=\(client_id)&client_secret=\(client_secret)&grant_type=\(grant_type)&username=\(username)&password=\(password)"
        tokenRequest.httpBody = parameters.data(using: .utf8)
        tokenRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: tokenRequest) { data, response, error in
            if let error = error {
                print("dataTask error: \(error.localizedDescription)")
                return
            } else {
                guard let response = response else {
                    print("Bad response")
                    return
                }
                print("response: \(response.expectedContentLength)")
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(TokenResponse.self, from: data)
                        
                        // print("Access token",response.access_token)
                        fetchData(token: response.access_token, context: persistenceController.container.viewContext)
                        
                    } catch let err {
                        print("Error: \(err)")
                    }
                }
            }
        }.resume()}
    
    
    func fetchData(token: String, context: NSManagedObjectContext) {
        // Set up the URL and headers
        guard let dataUrl = URL(string: "https://api-datahub.visitfinland.com/graphql/v1/graphql") else {
            print("Bad Url")
            return}
        var dataRequest = URLRequest(url: dataUrl)
        
        dataRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dataRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let graphQLBody = ["query": sampleGraphQLQuery]
        let jsonData = try! JSONSerialization.data(withJSONObject: graphQLBody, options: .prettyPrinted)
        
        // Set up the HTTP POST request with the GraphQL body
        dataRequest.httpMethod = "POST"
        dataRequest.httpBody = jsonData
        
        URLSession.shared.dataTask(with: dataRequest) { data, response, error in
            if let error = error {
                print("dataTask error: \(error.localizedDescription)")
                return
            } else {
                guard let response = response else {
                    print("Bad response")
                    return
                }
                print("response: \(response.expectedContentLength)")
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(SampleResponse.self, from: data)
                        
                        //print("Data: \(String(describing: String(data: data, encoding: .utf8)))")
                    
                        print("DATA: \(response.data.product)")
                        
                        // rest is core data related
                        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                        
                        var productInformationMap: [String:ProductInformations] = [:]
                        let productInformation = Set(response.data.product.map { item in item.productInformations })
                        
                        productInformation.forEach { inf in
                            let PI = ProductInformations(context: context)
                            print("INF--: ", inf)
                            
                            // PI.name = inf
                            //productInformationMap[inf] = PI
                        }

                        
                        
                        
                        
                        
                        
                    } catch let err {
                        print("Error: \(err)")
                    }
                }
                
            }
            
        }
        .resume()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}
*/
