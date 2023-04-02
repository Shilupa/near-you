//
//  ContentView.swift
//  NearYou
//
//  Created by Shilpa Singh on 2.4.2023.
//

import SwiftUI

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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
