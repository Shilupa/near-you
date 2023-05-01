//
//  DefaultLangViewModel.swift
//  NearYou
//
//  Created by Shilpa Singh on 21.4.2023.
//

import Foundation
import CoreData
import SwiftUI

// Sets default language for App
class DefaultLangViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedSetting: [MyDefaultLang] = []
    
    // Initializing CoreData
    init() {
        container = NSPersistentContainer(name: "DefaultLanguage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("ERROR loading Core Data: \(error), \(error.localizedDescription)")
            }
        })
        fetchSettings()
    }
    
    // Fetching values from coredata
    func fetchSettings(){
        let request = NSFetchRequest<MyDefaultLang>(entityName: "MyDefaultLang")
        do{
            try savedSetting =  container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching user data \(error)")
        }
    }
    
    // string lang: user pick default langugae choice
    // Adds default user language to Core Data
    func addDefaultLang(_ lang: String){
        let userDefault = MyDefaultLang(context: container.viewContext)
        userDefault.myLang = lang
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
