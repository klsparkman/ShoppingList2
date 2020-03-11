//
//  List+Convenience.swift
//  ShoppingList2
//
//  Created by Kelsey Sparkman on 3/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import Foundation
import CoreData

extension List {
    convenience init(title: String, moc: NSManagedObjectContext = CoreDataStack.contextMOC) {
        self.init(context: moc)
        self.title = title
    }
}
