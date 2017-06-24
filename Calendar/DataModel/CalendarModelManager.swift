//
//  CalendarModelManager.swift
//  Calendar
//
//  Created by Zhang, Eric X. on 4/26/17.
//  Copyright © 2017 ShangHe. All rights reserved.
//

import Foundation
import CoreData

/*********************************************************************
 *
 *  class CalendarModelManager -- Singleton
 *  This class is responsible for controlling the core data
 *
 *********************************************************************/

class CalendarModelManager {
    
    private static let coreDataFolderName = ".$CacheDB$"
    private static let tempUserName = "tempUser"
    private static let coreDataFileName = ".Cache.cache"
    
    // MARK: - Core Data stack
    
    //
    //  we won't use NSPersistentContainer, but use classic solution to creat managedObjectContext
    //
    
    //
    //  the url of user's folder
    //
    private lazy var userFolderUrl: URL? = {
        
        var retURL: URL? = nil
    
        let rootUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        
        //
        //  because we don't have real login account, so just use tempUser instead
        //
        let savedFolderUrl = rootUrl?.appendingPathComponent(tempUserName).appendingPathComponent(coreDataFolderName)
        
        if nil != savedFolderUrl
        {
            do
            {
                //
                //  try to create folder first
                //  I'm not sure why no Bool return in this API?
                //
                try FileManager.default.createDirectory(at: savedFolderUrl!, withIntermediateDirectories: true)
                
                retURL = savedFolderUrl
            }
            catch let error as NSError
            {
                fatalError("Create core data folder failed: \(error)")
            }
        }
        
        return retURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel? = {
    
        if let url = Bundle.main.url(forResource: "CalendarModel", withExtension: "momd")
        {
            return NSManagedObjectModel(contentsOf: url)
        }
        else
        {
            fatalError("Create managedObjectModel failed.")
        }
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        
        [unowned self] in
        
        if let objectModel = self.managedObjectModel
        {
            let coordinator = NSPersistentStoreCoordinator.init(managedObjectModel: objectModel)
            
            self.installPersistentStoreInCoordinator(coordinator)
            
            return coordinator
        }
        else
        {
            fatalError("Create persistentStoreCoordinator failed.")
        }
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        [unowned self] in
    
        if let persistentStoreCoordinator = self.persistentStoreCoordinator
        {
            let managedObjectContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
            
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            
            return managedObjectContext
        }
        else
        {
            fatalError("Create managedObjectContext failed.")
        }
    }()
    
    // MARK: Singleton init
    
    //
    //  singleton instance
    //
    static let sharedManager = CalendarModelManager()

    //
    //  prevent be init from others
    //
    private init() {

    }
    
    private func installPersistentStoreInCoordinator(_ coordinator: NSPersistentStoreCoordinator) {
    
        if let storedFolderUrl = self.userFolderUrl
        {
            let storedURL = storedFolderUrl.appendingPathComponent(CalendarModelManager.coreDataFileName)    // this is the core data sqlite data file url
            let options: [String : Any] = [NSSQLitePragmasOption : ["journal_mode" : "DELETE"], // delete wal mode files
                NSSQLiteManualVacuumOption : Int(true),
                NSMigratePersistentStoresAutomaticallyOption : Int(true),
                NSInferMappingModelAutomaticallyOption : Int(true),
                NSPersistentStoreFileProtectionKey : FileProtectionType.complete]
            
            do
            {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storedURL, options: options)
            }
            catch let error as NSError
            {
                //
                //  first time we find the error, we could remove the store file and retry
                //
                print("Unresolved error \(error), \(error.userInfo)")
                
                do
                {
                    //
                    //  try to create folder first
                    //  I'm not sure why no Bool return in this API?
                    //
                    try FileManager.default.removeItem(at: storedURL)
                }
                catch let error as NSError
                {
                    fatalError("Remove core data file failed: \(error)")
                }
                
                //
                //  then try again
                //
                do
                {
                    try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storedURL, options: options)
                }
                catch let error as NSError
                {
                    fatalError("Try add store again failed. Unresolved error \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    // MARK : Public Method
    
    /**
     
     Save core data
     
     - Parameter completion: completion callback (Since save core data will in background thread)
     
     - Returns: none
     
     */
    func saveCoreData (completion: ((Bool) -> Void)? = nil) {
        
        let context = self.managedObjectContext
        
        if context.hasChanges
        {
            //
            //  save core data in background thread
            //
            context.perform({
                
                [unowned context] in
                
                do
                {
                    try context.save()
                    
                    completion?(true)
                }
                catch let error as NSError
                {
                    print("Save core data context error \(error), \(error.userInfo)")
                    
                    completion?(false)
                }
            })
        }
    }
    
    /**
     
     Clear core data and remove saved file
     
     - Returns: none
     
     */
    func clearDB() {
        
        if let storedFolderUrl = self.userFolderUrl, let persistentStore = self.persistentStoreCoordinator?.persistentStores.last
        {
            let storedURL = storedFolderUrl.appendingPathComponent(CalendarModelManager.coreDataFileName)
            
            do
            {
                try self.persistentStoreCoordinator?.remove(persistentStore)

                try FileManager.default.removeItem(at: storedURL)
                
                print("Clear DB successful.")
                
                //
                //  re-install store
                //
                self.installPersistentStoreInCoordinator(self.persistentStoreCoordinator!)
            }
            catch let error as NSError
            {
                print("Clear DB error \(error), \(error.userInfo)")
            }
        }
    }
    
    /**
     
     Fetch core data objects by entity name and predicate
     
     - Parameter entityName:    entity name
     - Parameter predicate:     fetch predicate
     
     - Returns: fetched Array
     
     */
    func fetchObj(entityName: String, predicate: NSPredicate) -> Array<Any>? {
        
        var retResult: Array<Any>? = nil
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 0
        
        do
        {
            let result = try self.managedObjectContext.fetch(fetchRequest)
            
            if result.count > 0
            {
                retResult = result
            }
        }
        catch let error as NSError
        {
            print("Fetch core data failed \(error.userInfo)")
        }
        
        return retResult
    }
    
    /**
     
     Create core data object by entity name
     We won't save core data every time, please save core data when you need
     
     - Parameter entityName:    entity name
     
     - Returns: CoreData object
     
     */
    func createObj(entityName: String) -> NSManagedObject {
        
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: CalendarModelManager.sharedManager.managedObjectContext)
    }
}
