//
//  NSManagedObjectExtension.swift
//  StepUpiOS
//
//  Created by Michael Miscampbell on 16/03/2018.
//  Copyright © 2018 Michael Miscampbell. All rights reserved.
//

import Foundation
import CoreData

extension CoreDataModelProtocol where Self: NSManagedObject {
    public static func newInstance<T: CoreDataModelProtocol>(_ context: NSManagedObjectContext) -> T where Self: NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: T.entityName, into: context) as! T
    }
    
    public static func find<T>(_ context: NSManagedObjectContext) -> [T] {
        let fetchedData = fetchData(nil, sortBy: nil, ascending: nil, context: context)
        return fetchedData as! [T]
    }
    
    public func save(_ context: NSManagedObjectContext) {
        if !isSaved {
            let entity = NSEntityDescription.insertNewObject(forEntityName: type(of: self).entityName, into: context)
            if let attributes = NSEntityDescription .entity(forEntityName: type(of: self).entityName, in: context)?.attributesByName {
                for (attribute, description) in attributes {
                    entity.setValue(self.value(forKey: attribute), forKey: attribute)
                }
            }
        }
    }
    
    private var isSaved: Bool {
        get {
            return !self.objectID.isTemporaryID;
        }
    }
    
    private static func fetchData<T: NSManagedObject>(_ predicate: NSPredicate?, sortBy:String?, ascending: Bool?, context: NSManagedObjectContext) -> [T]
    {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        
        if let sortBy = sortBy {
            let sortDescriptor = NSSortDescriptor(key: sortBy, ascending: ascending!)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            Logger.error(message: "Fetch request failed", additionalData: ["EntityName": entityName, "Exception": error])
        } catch {
            Logger.error(message: "Fetch request failed", additionalData: ["EntityName": entityName, "Exception": error])
        }
        return []
    }
}
