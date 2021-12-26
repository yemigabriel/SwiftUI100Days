//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Yemi Gabriel on 12/23/21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject var coreDataController = CoreDataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataController.container.viewContext)
        }
    }
}
