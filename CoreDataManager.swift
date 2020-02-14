//
//  CoreDataManager.swift
//  CoreDataSample
//
//  Created by mcs on 1/29/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit
import CoreData
import os.log

final class CoreDataManager {
    private init() {}
    static let shared = CoreDataManager()
    let dataModelName = "CoreDataSample"
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataModelName)
        let description = NSPersistentStoreDescription()
        
        description.shouldMigrateStoreAutomatically = false
        description.shouldInferMappingModelAutomatically = false
        description.url = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent(dataModelName + ".sqllite")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: {
            _,error in
            
            if let error = error as NSError? {
                assertionFailure(error.localizedDescription)
            }
        })
        return container
    }()
    
    func saveContext(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            os_log("Core Data Save Failed", error.localizedDescription)
        }
    }
    
    func fetchObjects<T>(fetchRequest: NSFetchRequest<T>, context: NSManagedObjectContext) -> [T] {
        do{
            return try context.fetch(fetchRequest)
        } catch {
            os_log("Fetching objects from CoreData failted with error:", error.localizedDescription)
        }
        return []
    }
    
    func batchDelete(objects: [NSManagedObject], context: NSManagedObjectContext) {
        let objectIds: [NSManagedObjectID] = objects.map {$0.objectID}
        let batchDeleteRequest = NSBatchDeleteRequest(objectIDs: objectIds)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            os_log("Could not delete with error: ", error.localizedDescription)
        }
    }
}
