//
//  AddView.swift
//  iExpense
//
//  Created by Yemi Gabriel on 7/18/21.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showAlert = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text("\($0)")
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                    .foregroundColor(Int(amount) ?? 0 < 10 ? .blue : .green)
            }
            .navigationTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(amount) {
                    let item = Expense(name: name, type: type, amount: actualAmount)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                    return
                }
                errorTitle = "Oops!"
                errorMessage = "Please enter a valid number"
                showAlert = true
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
