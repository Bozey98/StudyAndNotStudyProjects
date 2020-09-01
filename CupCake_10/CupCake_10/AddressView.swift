//
//  AddressView.swift
//  CupCake_10
//
//  Created by Денис Мусатов on 12.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: MyOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                TextField("Street address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check Out")
                        .foregroundColor(.blue)
                }
            }.disabled(order.order.hasValidAddres == false)
        }
        
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: MyOrder())
    }
}
