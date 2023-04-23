//
//  DefaultViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 20.4.2023.
//

import Foundation
import CoreData
import SwiftUI

class DefaultViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedSetting: [DefaultEntity] = []
    
    // Initializing CoreData
    init() {
        container = NSPersistentContainer(name: "DefaultSettings")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("ERROR loading Core Data: \(error), \(error.localizedDescription)")
            }
        })
        fetchSettings()
    }
    
    // Fetching values from coredata
    func fetchSettings(){
        let request = NSFetchRequest<DefaultEntity>(entityName: "DefaultEntity")
        do{
            try savedSetting =  container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching user data \(error)")
        }
    }
    
    // Saving default View in Core Data
    func addDefaultView(_ listOrMap: Int32){
        let userDefault = DefaultEntity(context: container.viewContext)
        userDefault.listOrMap = listOrMap
        saveData()
    }
    
    // Saving data in Core Data
    func saveData(){
        do{
            try container.viewContext.save()
            fetchSettings()
        }catch let error{
            print("Error saving  user data \(error)")
        }
    }
}
