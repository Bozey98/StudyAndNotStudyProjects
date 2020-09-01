//
//  ContentView.swift
//  HackingWithSwift4
//
//  Created by Денис Мусатов on 28.05.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime : Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        return Calendar.current.date(from: component) ?? Date()
    }
    
    var bedtime: String {
        let model = SleepCalculator()
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hours = (components.hour ?? 0) * 3600
            let minutes = (components.minute ?? 0) * 60
            
            do {
                let predication = try model.prediction(wake: Double(hours + minutes),
                                                       estimatedSleep: sleepAmount,
                                                       coffee: Double(coffeeAmount))
                let sleepTime = wakeUp - predication.actualSleep
                
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                
                alertTitle = "Your perfect bedtime is..."
                return formatter.string(from: sleepTime)
            }
            catch {
                alertTitle = "Error"
                return "Sorry, there was some problems"
            }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                
                Section(header: Text("How much do you want to sleep"))  {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake"))  {
                    Picker("mem", selection: $coffeeAmount) {
                        ForEach(1..<13) { num in
                            if num == 1 {
                                Text("\(num) cup")
                            }
                            else {
                                Text("\(num) cups")
                            }
                        }
                    }.labelsHidden()
                }
  
                Section(header: Text("Your bedtime is")) {
                    Text(bedtime).font(.largeTitle)
                   
                }
                
                
                
                
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            .navigationBarTitle("BetterRest")
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
