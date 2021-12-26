//
//  ShipView.swift
//  CoreDataProject
//
//  Created by Yemi Gabriel on 12/25/21.
//

import SwiftUI

struct ShipView: View {
    @Environment(\.managedObjectContext) var moc
    
    //predicates ...
    //
    //    NSPredicate(format: "universe == 'Star Wars'")
    //    NSPredicate(format: "universe == %@", "Star Wars")
    //    NSPredicate(format: "name < %@", "F")
    //    NSPredicate(format: "name < %@", "En")
    //    NSPredicate(format: "universe IN %@", ["Aliens", "Lost in Space", "Firefly"])
    //    NSPredicate(format: "name BEGINSWITH %@", "E")
    //    NSPredicate(format: "name BEGINSWITH[c] %@", "E")
    //    NSPredicate(format: "universe CONTAINS %@", "lost")
    //    NSPredicate(format: "universe CONTAINS[c] %@", "lost")
    //    NSPredicate(format: "NOT universe CONTAINS[c] %@", "lost")
    
    // AND, NOT, compound predicates
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "NOT universe CONTAINS[c] %@", "lost")) var ships: FetchedResults<Ship>
    
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown")
            }
            
            Button("Add Ships") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Executor"
                ship2.universe = "Star Wars"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Discovery"
                ship3.universe = "Star Trek"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Millenium Falcon"
                ship4.universe = "Star Wars"
                
                let ship5 = Ship(context: moc)
                ship5.name = "Jupiter 2"
                ship5.universe = "Lost in Space"
                
                try? moc.save()
            }
        }
    }
}

struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        ShipView()
    }
}
