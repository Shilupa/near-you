//
//  DataViewModel.swift
//  NearYou
//
//  Created by Suraj Rana Bhat on 9.4.2023.
//

import Foundation

final class DataViewModel: ObservableObject {

    @Published var hasError = false
    @Published var error: DataError?
    @Published var allData: ProductResponse?
    @Published private(set) var isRefreshing = false
    @Published var typeTuple = [(typeCategory:String, categoryCount:Int)]()
    
    private let client_id = "datahub-api"
    private let client_secret = "ed7cd94f-727e-4cf7-879c-1c26f798bcc0"
    private let grant_type = "password"
    private let username = "bibek.shrestha@metropolia.fi"
    private let password = "Hello404Datahub!"
    
    private var typeArray: Array<String> = []
    private var typeSet: Set<String> = []
    
    init () {
        getData()
    }
    
    func getData(){
        
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
            
            DispatchQueue.main.async {
                
                if let error = error {
                    print("dataTask error: \(error.localizedDescription)")
                    return
                } else {
                    guard response != nil else {
                        print("Bad response")
                        return
                    }
                    
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(TokenResponse.self, from: data)
                            
                            self.fetchData(token: response.access_token)
                            
                        } catch let err {
                            print("Error: \(err)")
                        }
                    }
                }
            }}.resume()}
    
    func fetchData(token: String) {
        
        hasError = false
        isRefreshing = true
        
        guard let dataUrl = URL(string: "https://api-datahub.visitfinland.com/graphql/v1/graphql") else {
            print("Bad Url")
            return}
        var dataRequest = URLRequest(url: dataUrl)
        
        dataRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dataRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let graphQLBody = ["query": graphQLQuery]
        let jsonData = try! JSONSerialization.data(withJSONObject: graphQLBody, options: .prettyPrinted)
        
        // Set up the HTTP POST request with the GraphQL body
        dataRequest.httpMethod = "POST"
        dataRequest.httpBody = jsonData
        
        URLSession
            .shared
            .dataTask(with: dataRequest) {  [weak self]  data, response, error in
                
                DispatchQueue.main.async { [self] in
                    defer {
                        self?.isRefreshing = false
                    }
                    
                    if let error = error {
                        self?.hasError = true
                        self?.error = DataError.custom(error: error)
                    } else {
                        
                        let decoder = JSONDecoder()
                        
                        if let data = data,
                           let datas = try? decoder.decode(ProductResponse.self, from: data) {

                            self?.allData = datas

                        } else {
                            self?.hasError = true
                            self?.error = DataError.failedToDecode
                        }
                    }
                }
                
            }.resume()
        
    }
}


extension DataViewModel {
    enum DataError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
