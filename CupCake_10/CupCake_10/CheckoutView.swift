//
//  CheckoutView.swift
//  CupCake_10
//
//  Created by Денис Мусатов on 12.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: MyOrder
    @State private var showConfirm = false
    @State private var confirmMessage = ""
    @State private var alertTitle = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }.padding()
                }
            }
        }.alert(isPresented: $showConfirm) {
            Alert(title: Text(self.alertTitle), message: Text(self.confirmMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else  {
                print("No data in response \(error?.localizedDescription ?? "Unknown error")")
                self.alertTitle = "We're sorry :("
                self.confirmMessage = "There are connection troubles"
                self.showConfirm = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Orderr.self, from: data) {
                self.alertTitle = "Thank you"
                self.confirmMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on it's way"
                
            } else {
                self.alertTitle = "We're sorry :("
                self.confirmMessage = "There are some troubles, repeat through the minute"
            }
            self.showConfirm = true
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: MyOrder())
    }
}
