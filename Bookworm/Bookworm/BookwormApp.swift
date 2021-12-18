//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Yemi Gabriel on 12/17/21.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
