//
//  persistenceService.swift
//  CDProject
//
//  Created by Nathan on 4/21/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
import CoreData

class persistenceService {
    
    private init() {}
    
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CDProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("oops thats bad \(error), \(error.userInfo)")
            }
            
            
            
        })
        return container
    }()
    
    static func saveContext() { // can be called from view controller and will save stashed changes as well as handle errors
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
                print("SAVED!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
        }
    }
    
    
}
