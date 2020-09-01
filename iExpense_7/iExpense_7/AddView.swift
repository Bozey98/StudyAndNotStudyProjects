//
//  AddView.swift
//  iExpense_7
//
//  Created by Денис Мусатов on 03.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expanses : Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var alertToggle = false
    
    @Environment(\.presentationMode) var presentationMode
    
    static let types = ["Business", "Personal"]
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach (Self.types, id: \.self) {type in
                        Text("\(type)")
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expanse")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expanses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.alertToggle.toggle()
                }
                
            })
        }.alert(isPresented: $alertToggle) {
            Alert(title: Text("Wrong amount"), message: Text("Please enter correct amount"), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expanses: Expenses())
    }
}
