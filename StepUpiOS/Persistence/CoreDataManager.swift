//
//  CoreData.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 01/03/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
    public static private(set) var sharedInstance: CoreDataManager!
    private let configuration: CoreDataConfiguration
    
    private init(_ configuration: CoreDataConfiguration) {
        self.configuration = configuration
        CoreDataManager.sharedInstance = self
    }
    
    public static func initialise(_ configuration: CoreDataConfiguration)
    {
        if let _ = CoreDataManager.sharedInstance {
            fatalError("CoreData has already been initialised")
        }
        
        _ = CoreDataManager(configuration)
    }
    
    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: self.configuration.dataModel, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("\(self.configuration.persistanceStoreName).sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType,
                                                configurationName: nil,
                                                at: url,
                                                options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(String(describing: error)), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
    
    public lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.savingManagedObjectContext
        
        return managedObjectContext
        
    }()
    
    
    private lazy var savingManagedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        
        var savingManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        savingManagedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        savingManagedObjectContext.persistentStoreCoordinator = coordinator
        return savingManagedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    public func saveContext (onCompletion: (() -> Void)? = nil) {
        if !self.managedObjectContext.hasChanges && !self.savingManagedObjectContext.hasChanges {
            onCompletion?()
            return
        }
        
        self.managedObjectContext.performAndWait({ () -> Void in
            Logger.debug(message: "Saving on MAIN Thread")
            var error:NSError?
            var result: Bool
            do {
                try self.managedObjectContext.save()
                result = true
                onCompletion?()
            } catch let error1 as NSError {
                error = error1
                Logger.error(message: "ERROR Saving on MAIN Thread \(error1)")
                result = false
            } catch {
                fatalError()
            }
            
            if result == false
            {
                Logger.error(message: "Error saving managed object context on main thread: \(String(describing: error?.description))")
                abort()
            }
            
            self.savingManagedObjectContext.perform({ () -> Void in
                Logger.debug(message: "Saving on SAVE Thread")
                var error:NSError?
                var result: Bool
                do {
                    try self.savingManagedObjectContext.save()
                    result = true
                } catch let error1 as NSError {
                    error = error1
                    result = false
                    Logger.error(message: "ERROR Saving on SAVE Thread \(error1)")
                } catch {
                    fatalError()
                }
                
                if result == false {
                    Logger.error(message: "Error saving context to disk \(String(describing: error?.description))")
                    abort()
                }
            })
            
        })
    }
}

public struct CoreDataConfiguration {
    public let dataModel: String
    public let persistanceStoreName: String
    
    public init(dataModel: String, persistanceStoreName: String) {
        self.dataModel = dataModel
        self.persistanceStoreName = persistanceStoreName
    }
}
