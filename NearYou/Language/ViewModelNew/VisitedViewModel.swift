//
//  VisitedViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 1.5.2023.
//

import Foundation
import CoreData
import SwiftUI

class VisitedViewModel: ObservableObject {
    //static let shared = CoreDataViewModel()
    let container: NSPersistentContainer
    @Published var savedSetting: [Places] = []
    
    // Initializing CoreData
    init() {
        container = NSPersistentContainer(name: "VisitedPlaces")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("ERROR loading Core Data: \(error), \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        })
        fetchSettings()
    }
    
    // Fetching values from coredata
    func fetchSettings(){
        let request = NSFetchRequest<Places>(entityName: "Places")
        do{
            try savedSetting =  container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching user data \(error)")
        }
    }
    
    // Adding user data to Core Data
    func addPlace(_ id: String){
        let place = Places(context: container.viewContext)
        place.placeId = id
        saveData()
        print("Data saved")
    }
    
    // Deletes visited from Core Data by favouriteId
    func deleteVisited(_ id: String){
        let fetchRequest = NSFetchRequest<Places>(entityName: "MyPlaces")
        fetchRequest.predicate = NSPredicate(format: "placeId == %@", id)
        // Searches for entity with given id in Core Data and returns entity if found
        guard let entity = try? container.viewContext.fetch(fetchRequest).first else {
            return
        }
        // Deletes entity from CoreData
        container.viewContext.delete(entity)
        saveData()
    }
    
    // Deletes all Entity for Core Data
    // Just in case to clear data base
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Places")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try container.viewContext.execute(deleteRequest)
            saveData()
            print("deleted")
        } catch let error as NSError {
            print("Error deleting all data: \(error.localizedDescription)")
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

class PlaceImageViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedSetting: [PlaceImage] = []
    
    // Initializing CoreData
    init() {
        container = NSPersistentContainer(name: "VisitedPlaceImages")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("ERROR loading Core Data: \(error), \(error.localizedDescription)")
            }
        })
        fetchSettings()
    }
    
    // Fetching values from coredata
    func fetchSettings(){
        let request = NSFetchRequest<PlaceImage>(entityName: "PlaceImage")
        do{
            try savedSetting =  container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching user data \(error)")
        }
    }
    
    // Adding image data to Core Data
    func addPlaceImage(_ id: String,  _ selectedImage: UIImage?){
        let placeImage = PlaceImage(context: container.viewContext)
        // Adding image to Core Data
        guard let imageData = selectedImage?.jpegData(compressionQuality: 1.0) else { return }
        placeImage.placeId = id
        placeImage.placeImage = imageData
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
    
    // Deletes visited from Core Data by favouriteId
    func deletePlaceImage(_ id: String){
        let fetchRequest = NSFetchRequest<PlaceImage>(entityName: "PlaceImage")
        fetchRequest.predicate = NSPredicate(format: "placeId == %@", id)
        // Searches for entity with given id in Core Data and returns entity if found
        guard let entity = try? container.viewContext.fetch(fetchRequest).first else {
            return
        }
        // Deletes entity from CoreData
        container.viewContext.delete(entity)
        saveData()
    }
}

