//
//  ContentView.swift
//  CupCake_10
//
//  Created by Денис Мусатов on 12.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = MyOrder()
  
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.order.type) {
                        ForEach(0..<Order.types.count) { type in
                            Text(Order.types[type])
                        }
                    }
                    Stepper(value: $order.order.quantity, in: 3...20) {
                        Text("Number of cakes : \(order.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn:$order.order.specialRequestEnable.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.order.specialRequestEnable {
                        Toggle(isOn: $order.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery detail")
                    }
                }
                    
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
