//
//  ContentView.swift
//  NearYou
//
//  Created by Shilpa Singh on 2.4.2023.
//

import SwiftUI

/*
struct ContentView: View {
    private let client_id = "datahub-api"
    private let client_secret = "ed7cd94f-727e-4cf7-879c-1c26f798bcc0"
    private let grant_type = "password"
    private let username = "bibek.shrestha@metropolia.fi"
    private let password = "Hello404Datahub!"
    
    var body: some View {
        VStack {
 //           TextField("Username", text: $username)
 //           SecureField("Password", text: $password)
            Button("Get Data") {
                getData()
            }}}
    
    func getData() {
        
        struct TokenResponse: Codable{
            let access_token: String
        }
        guard let url = URL(string: "https://iam-datahub.visitfinland.com/auth/realms/Datahub/protocol/openid-connect/token") else {
            fatalError("Failed to create URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = "client_id=\(client_id)&client_secret=\(client_secret)&grant_type=\(grant_type)&username=\(username)&password=\(password)"
        request.httpBody = parameters.data(using: .utf8)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if String(data: data, encoding: .utf8) != nil {
                    
                    do{
                        let user = try JSONDecoder().decode(TokenResponse.self, from: data)
                        print("Access token",user.access_token)
                    }catch let error {
                        print ("Error", error)
                    }
                    
                }
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()}}


struct ContentView: View {
    
    @State private var result: String = ""
    
    var body: some View {
        VStack {
            Text(result)
                .padding()
            Button("Fetch Data") {
                fetchData()
            }
        }
    }
    
    func fetchData() {
        // Set up the URL and headers
        let url = URL(string: "https://api-datahub.visitfinland.com/graphql/v1/graphql")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJTVHBXWjYweXQ5dkN6aGt3UEo2aTU0WjRDaEhDTmFydkl1aXF1VF9XN1RRIn0.eyJleHAiOjE2ODA0NzEzMzUsImlhdCI6MTY4MDQ2NzczNSwianRpIjoiYWZmOTc3MzYtYTA2NC00ZGMwLWIyNjEtMjUxMTBjZTU4MGQxIiwiaXNzIjoiaHR0cHM6Ly9pYW0tZGF0YWh1Yi52aXNpdGZpbmxhbmQuY29tL2F1dGgvcmVhbG1zL0RhdGFodWIiLCJzdWIiOiI2MjhlMGE2OS05OGQxLTRhM2ItYTIyYi01MTRkOWEyOWU0NjMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJkYXRhaHViLWFwaSIsInNlc3Npb25fc3RhdGUiOiI4NDRiMjAyMS1lY2JmLTRhYTQtOGViOS05NmEzMWY0NjQ3NjQiLCJhY3IiOiIxIiwicmVzb3VyY2VfYWNjZXNzIjp7ImRhdGFodWItYXBpIjp7InJvbGVzIjpbImFwaS11c2VyIl19fSwic2NvcGUiOiJlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJCaWJlayBTaHJlc3RoYSIsInByZWZlcnJlZF91c2VybmFtZSI6ImJpYmVrLnNocmVzdGhhQG1ldHJvcG9saWEuZmkiLCJnaXZlbl9uYW1lIjoiQmliZWsiLCJmYW1pbHlfbmFtZSI6IlNocmVzdGhhIiwiZW1haWwiOiJiaWJlay5zaHJlc3RoYUBtZXRyb3BvbGlhLmZpIn0.O1Xk8Sx0eksb04NDDN5CxZQ1aL1NFMeDMnxmbk4_HViKEsI7d1xjPQ2NkQkR5jlcwgWoFQPvAXgsm2eHKXgcOnERyVq1sllmdnHcP3rP0qXYtexmIpYQgLGgycZAxiDWHgUV_oV14GsDXXETqm0gauzNJAtxI30I5EZL_6tJeVyhwRMHQfxeWl_42bXAuY976XVxCxQMYY0hH5dCmrVjKMBXFkFCNlFTZF4cPmS0KTa2frOpjd1e3TzJ05UiAJwj3BPjxpRPL6z-S1y3Sa9DdzWx4V3TnQFU1KKE8KnGiiH-Z6waYBiDRXZ9bpI3GwhhqNY-lMYtvUZIrDv01igi0w", forHTTPHeaderField: "Authorization")
        
        // Set up the GraphQL query
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
        let graphQLBody = ["query": graphQLQuery]
        let jsonData = try! JSONSerialization.data(withJSONObject: graphQLBody, options: .prettyPrinted)
        
        // Set up the HTTP POST request with the GraphQL body
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        // Send the HTTP request and parse the response
        /*
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Error: HTTP status code \(httpResponse.statusCode)")
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            let prettyJson = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let prettyString = String(data: prettyJson, encoding: .utf8)!
            DispatchQueue.main.async {
                self.result = prettyString
            }
        }*/
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let dataResponse = String(data: data, encoding: .utf8) {
                    
                    print("Data: \(dataResponse)")
                    
                }
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
        }
        .resume()
    }
}
 */

struct ContentView: View {
    private let client_id = "datahub-api"
    private let client_secret = "ed7cd94f-727e-4cf7-879c-1c26f798bcc0"
    private let grant_type = "password"
    private let username = "bibek.shrestha@metropolia.fi"
    private let password = "Hello404Datahub!"
    
    var body: some View {
        VStack {
            Button("Get Data") {
                getData()
            }}}
    
    func getData() {
        
        // token response struct class to extract token data
        struct TokenResponse: Codable{
            let access_token: String
        }
        
        // Get the URL for bearer token
        guard let tokenUrl = URL(string: "https://iam-datahub.visitfinland.com/auth/realms/Datahub/protocol/openid-connect/token") else {
            fatalError("Failed to create URL")
        }
        
        // Setting token Request
        var tokenRequest = URLRequest(url: tokenUrl)
        tokenRequest.httpMethod = "POST"
        let parameters = "client_id=\(client_id)&client_secret=\(client_secret)&grant_type=\(grant_type)&username=\(username)&password=\(password)"
        tokenRequest.httpBody = parameters.data(using: .utf8)
        tokenRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: tokenRequest) { data, response, error in
            if let data = data {
                if String(data: data, encoding: .utf8) != nil {
                    
                    do{
                        let response = try JSONDecoder().decode(TokenResponse.self, from: data)
                        // print("Access token",response.access_token)
                        
                        fetchData(token: response.access_token)
                        
                    }catch let error {
                        print ("Error", error)
                    }
                    
                }
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()}
    
    func fetchData(token: String) {
        // Set up the URL and headers
        let url = URL(string: "https://api-datahub.visitfinland.com/graphql/v1/graphql")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Set up the GraphQL query
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
        let graphQLBody = ["query": graphQLQuery]
        let jsonData = try! JSONSerialization.data(withJSONObject: graphQLBody, options: .prettyPrinted)
        
        // Set up the HTTP POST request with the GraphQL body
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        // Send the HTTP request and parse the response
        /*
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Error: HTTP status code \(httpResponse.statusCode)")
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            let prettyJson = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let prettyString = String(data: prettyJson, encoding: .utf8)!
            DispatchQueue.main.async {
                self.result = prettyString
            }
        }*/
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let dataResponse = String(data: data, encoding: .utf8) {
                    
                    print("Data: \(dataResponse)")
                    
                }
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
        }
        .resume()
    }
    
    
    
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
