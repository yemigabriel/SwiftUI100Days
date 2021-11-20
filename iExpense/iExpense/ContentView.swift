//
//  ContentView.swift
//  iExpense
//
//  Created by Yemi Gabriel on 7/14/21.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstname = "Natasha"
    @Published var lastname = "Romanov"
}

struct Expense: Codable, Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    static let EXPENSE_ITEMS = "ExpenseItems"
    
    @Published var items = [Expense]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: Self.EXPENSE_ITEMS)
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: Self.EXPENSE_ITEMS) {
            if let decoded = try? JSONDecoder().decode([Expense].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
}

struct ContentView: View {
//    @Environment(\.pre)
    @ObservedObject var user = User()
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { expense in
                    HStack {
                        VStack(alignment:.leading) {
                            Text("\(expense.name)")
                                .font(.headline)
                            Text("\(expense.type)")
                                .font(.body)
                        }
                        Spacer()
                        Text("$\(expense.amount)")
                            .font(.title)
                    }
                }
//                .onDelete(perform: { indexSet in
//                    expenses.items.remove(atOffsets: indexSet)
//                })
                .onDelete(perform: removeExpense)
            }
            
            .navigationTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: showSheet) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
    }
    
    func removeExpense(at indexSet: IndexSet) {
        expenses.items.remove(atOffsets: indexSet)
    }
    
    func showSheet() {
        showingAddExpense = true
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
