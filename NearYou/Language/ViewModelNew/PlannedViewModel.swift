//
//  PlannedViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 26.4.2023.
//

import Foundation
import CoreData
import SwiftUI

// Sets user planned list
class PlannedViewModel: ObservableObject{
    //static let shared = CoreDataViewModel()
    let container: NSPersistentContainer
    @Published var savedSetting: [Planned] = []
    
    // Initializing CoreData
    init() {
        container = NSPersistentContainer(name: "MyPlanned")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("ERROR loading Core Data: \(error), \(error.localizedDescription)")
            }
        })
        fetchSettings()
    }
    //Fetching values fron coredata
    func fetchSettings(){
        let request =
        NSFetchRequest<Planned>(entityName:"Planned")
        do{
            try savedSetting =
            container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching user data \(error)")
        }
    }
    
    // Adds planned data to Core Data
    func addplanned(_ id : String){
        let planned = Planned(context: container.viewContext)
        planned.plannedId = id
        saveData()
    }
    
    // Deletes planned from Core Data by plannedId
    func deletePlanned(_ id: String){
        let fetchRequest = NSFetchRequest<Planned>(entityName: "Planned")
        fetchRequest.predicate = NSPredicate(format: "plannedId == %@", id)
        // Searches for entity with given id in Core Data and returns entity if found
        guard let entity = try? container.viewContext.fetch(fetchRequest).first else {
            return
        }
        // Deletes entity from CoreData
        container.viewContext.delete(entity)
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
