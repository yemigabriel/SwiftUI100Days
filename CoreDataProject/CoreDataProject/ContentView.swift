//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Yemi Gabriel on 12/23/21.
//
//  Practice

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors:[]) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        CandyView()
//        SingersView()
//        ShipView()
//        ScrollView {
//            //unique constraints
//            VStack {
//                List(wizards, id: \.self) { wizard in
//                    Text(wizard.name ?? "Unknown Wizard")
//                }.frame(height: 200)
//                Button("Add Wizard") {
//                    let wizard = Wizard(context: moc)
//                    wizard.name = "Harry Potter"
//                }
//                Button("Save wizard") {
//                    do {
//                        try moc.save()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            Rectangle()
//                .frame(height: 1)
//            //conditional save
//            Button("Conditional Save") {
//                if moc.hasChanges {
//                    try? moc.save()
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
