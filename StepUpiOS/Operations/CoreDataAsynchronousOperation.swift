//
//  CoreDataAsynchronousOperation.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 08/07/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation
import CoreData

open class CoreDataAsynchronousOperation: AsynchronousOperation
{
    internal let privateManagedObjectContext:NSManagedObjectContext
    
    public init(context managedObjectContext: NSManagedObjectContext) {
        self.privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.privateManagedObjectContext.parent = managedObjectContext
        super.init()
    }
    
    internal func retrieveThreadSafeCoreDataObject<T:NSManagedObject>(_ objectID: NSManagedObjectID) -> T?
    {
        var threadSafeObject:T?
        
        self.privateManagedObjectContext.performAndWait {
            do {
                threadSafeObject = try privateManagedObjectContext.existingObject(with: objectID) as? T
            } catch {
                Logger.error(message: "Unable to retrieve Core Data object", additionalData: ["Exception" : error,
                                                                                              "Operation": String(describing: type(of: self))])
                self.cancel()
            }
        }
        
        return threadSafeObject
    }
    
    internal func saveThreadSafeCoreDataChanges()
    {
        self.privateManagedObjectContext.perform {
            if self.privateManagedObjectContext.hasChanges {
                do {
                    let insertedObjectsArray = Array(self.privateManagedObjectContext.insertedObjects)
                    try self.privateManagedObjectContext.obtainPermanentIDs(for: insertedObjectsArray)
                    
                    try self.privateManagedObjectContext.save()
                } catch {
                    let caughtError = error as NSError
                    Logger.error(message: "Unable to save changes to Managed Object Context", additionalData: ["Exception" : caughtError, "Operation": String(describing: type(of: self))])
                }
            }
        }
    }
}
