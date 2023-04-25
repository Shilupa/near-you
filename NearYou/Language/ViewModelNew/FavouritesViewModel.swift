//
//  FavouritesViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 24.4.2023.
//

import Foundation
import CoreData
import SwiftUI

class FavouritesViewModel: ObservableObject {
    //static let shared = CoreDataViewModel()
    let container: NSPersistentContainer
    @Published var savedSetting: [Favourites] = []
    
    // Initializing CoreData
    init() {
        container = NSPersistentContainer(name: "MyFavourites")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("ERROR loading Core Data: \(error), \(error.localizedDescription)")
            }
        })
        fetchSettings()
    }
    
    // Fetching values from coredata
    func fetchSettings(){
        let request = NSFetchRequest<Favourites>(entityName: "Favourites")
        do{
            try savedSetting =  container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching user data \(error)")
        }
    }
    
    // Adding user data to Core Data
    func addfavourite(_ id : String){
        let favourite = Favourites(context: container.viewContext)
        favourite.favouriteId = id
        saveData()
    }
    
    func deleteFavourite(_ id: String){
        let fetchRequest = NSFetchRequest<Favourites>(entityName: "Favourites")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        // Delete the entity if it exists
        if let entityToDelete = self.savedSetting.first {
            container.viewContext.delete(entityToDelete)
            saveData()
        }
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
