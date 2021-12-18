//
//  DataController.swift
//  Bookworm
//
//  Created by Yemi Gabriel on 12/18/21.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data refused to load: \(error.localizedDescription)")
            }
        }
    }
    
}
