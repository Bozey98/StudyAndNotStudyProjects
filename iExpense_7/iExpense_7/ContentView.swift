//
//  ContentView.swift
//  iExpense_7
//
//  Created by Денис Мусатов on 02.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpanse = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) {item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)")
                                .font(.headline)
                            Text("\(item.type)")
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(item.amount < 10 ? Color.green : item.amount < 100 ? Color.blue : Color.purple)
                    }
                    
                }
                .onDelete(perform: deleteItem)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(
                    action: {
                        self.showingAddExpanse = true
                },  label:  {
                        Image(systemName: "plus")
            }))
 
        }.sheet(isPresented: $showingAddExpanse) {
            AddView(expanses: self.expenses)
        }
    }
    func deleteItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
