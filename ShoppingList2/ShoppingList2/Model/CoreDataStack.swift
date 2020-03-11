//
//  CoreDataStack.swift
//  ShoppingList2
//
//  Created by Kelsey Sparkman on 3/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingList2")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores \(error)")
            }
        }
        return container
    }()
    
    static var contextMOC: NSManagedObjectContext {
        return container.viewContext
    }
    
}

