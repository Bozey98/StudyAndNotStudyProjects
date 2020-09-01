//
//  ContentView.swift
//  ActivityApp
//
//  Created by Денис Мусатов on 07.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAddmenu = false
    //@Environment(\.presentationMode) var presentation
    @ObservedObject var activities = Activities()
    @State private var editMode = false
    
    
    var body: some View {
        NavigationView {
          
            ScrollView(.vertical) {
                //ScrollView(.vertical) {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation(Animation.default.delay(0.1)) {
                                self.editMode.toggle()
                            }
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .foregroundColor(editMode ? .red : .blue)
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                        Text("Activity App")
                            .font(.system(size: 40, weight: .heavy, design: .rounded))
                            .opacity(0.7)
                        Spacer()
                        Button(action: {
                            self.add()
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                    }.padding(.horizontal)
                    
                    Divider()
                    
                    ForEach(activities.activities) { act in
                        ZStack(alignment: .center) {
                            
                            NavigationLink(destination: DetailActivity(activity: act)) {
                                ContentRow(activity: act)
                                    .padding(.vertical, 35)
                                    
                                    .offset(self.editMode ? CGSize(width: -40, height: 0) : .zero)
                            }.disabled(self.editMode)
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.deleteActivity(activity: act)
                                }) {
                                Image(systemName: "xmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 21)
                                    .opacity(self.editMode ? 1 : 0)
                                    .foregroundColor(.red)
                                    .offset(x: -10, y: 10)
                                        
                                }
                                
                            }
       
                        }
                            
                    }
                }.frame(maxWidth: .infinity)
            }
                    
                    
            .navigationBarTitle("Activity App", displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
                
        }.sheet(isPresented: $showAddmenu){
            ActivityCreator(activities: self.activities)
            
        }
    
    }
    
    func add() {
        print(showAddmenu)
        self.editMode = false
        self.showAddmenu.toggle()
    }
    
    func deleteActivity(activity: Activity) {
        self.activities.activities.removeAll(where: {$0.id == activity.id})
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
