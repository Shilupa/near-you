//
//  MyProfile.swift
//  NearYou
//
//  Created by Shilpa Singh on 23.4.2023.
//

import Foundation
import CoreData
import SwiftUI

class MyProfileViewModel: ObservableObject {
    //static let shared = CoreDataViewModel()
    let container: NSPersistentContainer
    @Published var savedSetting: [MyData] = []
    
    // Initializing CoreData
    init() {
        container = NSPersistentContainer(name: "MyProfile")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("ERROR loading Core Data: \(error), \(error.localizedDescription)")
            }
        })
        fetchSettings()
    }
    
    // Fetching values from coredata
    func fetchSettings(){
        let request = NSFetchRequest<MyData>(entityName: "MyData")
        do{
            try savedSetting =  container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching user data \(error)")
        }
    }

    // Adding user data to Core Data
    func addUser(_ name: String, _ address: String, _ selectedImage: UIImage?){
        // Assigning default value if name or address is empty string
        let savedName = self.savedSetting.last?.my_Name == "" ? "Not Set" : self.savedSetting.last?.my_Name
        let savedAddress = self.savedSetting.last?.my_Address == "" ? "Not Set" : self.savedSetting.last?.my_Address
        
        let user = MyData(context: container.viewContext)
        user.my_Name = name == "" ? savedName : name
        user.my_Address = address == "" ? savedAddress : address
        
        // Adding image to Core Data
        guard let imageData = selectedImage?.jpegData(compressionQuality: 1.0) else { return }
        user.my_Image = imageData
        saveData()
    }

    // Saving data in Core Data
    func saveData(){
        do{
            try container.viewContext.save()
            // User data is fetched as soon as user data is saved
            fetchSettings()
        }catch let error{
            print("Error saving  user data \(error)")
        }
    }

}

