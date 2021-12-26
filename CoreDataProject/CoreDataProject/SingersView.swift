//
//  SingersView.swift
//  CoreDataProject
//
//  Created by Yemi Gabriel on 12/25/21.
//

import SwiftUI
import CoreData

struct SingersView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct SingersView_Previews: PreviewProvider {
    static var previews: some View {
        SingersView()
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    //change to generics
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
//            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, content: @escaping (T) -> Content) {
        // _fetchRequest - a whole new Fetch request object not just the fetched results...
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
