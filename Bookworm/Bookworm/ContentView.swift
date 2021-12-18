//
//  ContentView.swift
//  Bookworm
//
//  Created by Yemi Gabriel on 12/17/21.
//

import SwiftUI


struct ContentView: View {
    @AppStorage("notes") private var notes = ""
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        NavigationView {
            VStack {
                List(students) { student in
                    Text(student.name ?? "Unknown")
                }
                
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Potter", "Lovegood", "Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(context: moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"
                    
                    do {
                        try moc.save()
                    } catch {
                        
                    }
                }
                
                TextEditor(text: $notes)
                    .navigationTitle("Notes")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
