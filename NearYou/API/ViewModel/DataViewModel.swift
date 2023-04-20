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
                    guard let response = response else {
                        print("Bad response")
                        return
                    }
                    print("response: \(response.expectedContentLength)")
                    
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
    //Sebastian - bla
    struct Location: Codable {
        var location: String
        var postalCode: String
        var streetName: String
        var city: String
    }
    
    //Sebastian - this is where it ends
    
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
                            
                            // creating array and set of category
                            for item in datas.data.product{
                                self?.typeArray.append(item.type!)
                                self?.typeSet.insert(item.type!)
                            }
                            
                            // Creating tuple of category with the its count
                            for item in self!.typeSet{
                                let count = self?.typeArray.reduce(0) { $1 == item ? $0 + 1 : $0 }
                                self?.typeTuple.append((item, count!))
                            }
                            
                            // Sorting tuple and publishing to use by all views
                            let Temp = self!.typeTuple.sorted { $0.categoryCount > $1.categoryCount }
                            self?.typeTuple = Temp
                            
                            //print("Data: ", datas.data.product)
                            self?.allData = datas
                            
                            //Sebastian - This is for accessing location data
                            let products = datas.data.product
                            for product in products {
//                                if let postalAddresses = product.postalAddresses?.first {
                                    for postalAddress in product.postalAddresses ?? [] {
                                        let locationString = postalAddress.location
//                                        let coordinates = locationString.replacingOccurrences(of: "(", with: "")
//                                            .replacingOccurrences(of: ")", with: "")
//                                            .components(separatedBy: ",")
//                                            .compactMap { Double($0.trimmingCharacters(in: .whitespaces)) }
                                        let coordinates = locationString?.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "") })
                                        let latitude = Double(coordinates?.first ?? "0")
                                        let longitude = Double(coordinates?.last ?? "0")
                                        if let latitude = Double(coordinates?.first ?? "0") {
                                            print("latitude= ", latitude)
                                        } else {
                                            print("Wrong latitude: \(coordinates?.first ?? "nil")")
                                        }
                                        if let longitude = Double(coordinates?.last ?? "0") {
                                            print("longitude= ", longitude)
                                        } else {
                                            print("Wrong longitude: \(coordinates?.last ?? "nil")")
                                        }
                                        
                                        
                                        var productLocation = ProductResponse.Location(latitude: latitude, longitude: longitude)
//                                        product.location = productLocation
                                        
                                        if let latitude = Double(coordinates?[0] ?? ""), let longitude = Double(coordinates?[1] ?? "") {
                                            productLocation.latitude = latitude
                                            productLocation.longitude = longitude
                                        } else {
//                                            print("Invalid coordinates: \(location)")
                                        }
                                    }
//                                }
                            }
                            
                            //                            let products = datas.data.product
                            //                            for product in products {
                            //                                for postalAddress in product.postalAddresses {
                            //                                    let locationArray = postalAddress.location
                            //                                        .replacingOccurrences(of: "(", with: "")
                            //                                        .replacingOccurrences(of: ")", with: "")
                            //                                        .split(separator: ",")
                            //
                            //                                    guard locationArray.count == 2,
                            //                                          let latitude = Double(locationArray[0]),
                            //                                          let longitude = Double(locationArray[1]) else {
                            //                                        print("Invalid location data: \(postalAddress.location)")
                            //                                        continue
                            //                                    }
                            //                                    let location = Location(latitude: latitude, longitude: longitude)
                            //                                    postalAddress.location = location
                            //
                            //                                }
                            //                            }
                            //
                            //                            self.products = products
                            //                            self.delegate?.didFetchData()
                            
                            //                            if let products = self?.allData?.data.product {
                            //                                for product in products {
                            //                                    if let location = produ
                            //                                }
                            //                            }
                            
                            
                            //Sebastian - this is where my part ends
                            
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
