//
//  CoreDataController.swift
//  CoreDataProject
//
//  Created by Yemi Gabriel on 12/23/21.
//

import Foundation
import CoreData

class CoreDataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Error: \(error.localizedDescription)")
            }
            // merge policy
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
        }
    }
    
}
