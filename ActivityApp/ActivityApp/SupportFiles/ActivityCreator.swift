//
//  ActivityCreator.swift
//  ActivityApp
//
//  Created by Денис Мусатов on 07.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ActivityCreator: View {
    
    @ObservedObject var activities : Activities
    @Environment(\.presentationMode) var presentation
    @State private var activityName = ""
    @State private var description = ""
    @State private var time = ""
    @ObservedObject var typeName = TempActivityType()
    var body: some View {
        
        ScrollView(.vertical) {
            VStack {
                CreatorHeader()
                    
                InputForm(color: .purple, text: "Activity Name", captureValue: $activityName)
                InputForm(color: .pink, text: "Description", captureValue: $description)
                InputForm(color: .red, text: "Time take", captureValue: $time)
                InputSelection(type: typeName)
                
                Button(
                    action: {
                        self.saveData()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .shadow(radius: 6)
                            Text("Save")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                        }
                        .frame(width: 200, height: 50)
                        .padding()
                    }
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    func saveData() {
        //print(self.typeName.type)
        self.activities.activities.append(Activity(activityName: activityName, description: description, timeTake: time, activityType: typeName.type))
        self.presentation.wrappedValue.dismiss()
    }
}

struct InputForm: View {
    let color: Color
    let text: String
    @State var captureValue: Binding<String>
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .shadow(radius: 10)
            TextField(text, text: captureValue)
                .padding(.horizontal)
                .foregroundColor(.white)
                .font(.system(size: 23, weight: .regular, design: .rounded))
        }
        .frame(width: 350, height: 80)
        .padding(10)
    }
}

struct InputSelection: View {
    @ObservedObject var type: TempActivityType
    let choice : [Activity.ActivityType] = [.education, .homeWork, .sport, .other]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(choice, id: \.self) { type in
                    Button(action: {
                        self.selectorTap(value: type)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.green)
                                .opacity(self.type.type == type ? 0.5 : 1.0)
                                .frame(width: 120, height: 60)
                                .shadow(radius: 7)
                            Text("\(self.valueSelecotor(type))")
                                .foregroundColor(.white)
                        }
                    }
                }
            }.frame(height: 90)
            .padding([.leading, .trailing] , 75)
        }
        
    }
    
    func selectorTap(value: Activity.ActivityType) {
        type.type = value
    }
    
    func valueSelecotor(_ value: Activity.ActivityType) -> String {
        switch value {
            case .education:
                return "Education"
            case .homeWork:
                return "Home Work"
            case .sport:
                return "Sport"
            case .other:
                return "Other"
        }
    }
}

class TempActivityType: ObservableObject {
    @Published var type : Activity.ActivityType = .education
}

struct ActivityCreator_Previews: PreviewProvider {
    
    static var previews: some View {
        ActivityCreator(activities: Activities())
    }
}
