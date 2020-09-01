//
//  DetailActivity.swift
//  ActivityApp
//
//  Created by Денис Мусатов on 09.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct DetailActivity: View {
    
    let activity: Activity
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        
       
            ZStack {
                    Image(activity.image)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .offset(CGSize(width: -210, height: 0))
                    Rectangle()
                        .fill(Color.black)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.8)
                        
                    
                    
                    
                    VStack(alignment: .leading) {
                    
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(activity.color)
                                .frame(height: 150)
                                .edgesIgnoringSafeArea(.all)
                                .opacity(0.6)
                                
                            HStack {
                                
                                Button(action: {
                                    self.presentation.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "chevron.left")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 30)
                                        .padding(.trailing)
                                    
                                }
                                    
                                    
                                Text(activity.activityName)
                                    .foregroundColor(.white)
                                    .font(.system(size: 45, weight: .heavy, design: .rounded))
                                    .opacity(0.8)
                                    
                                    
                            }.padding([.leading,.bottom])
                        }
                        
                        
                        TextShape(color: activity.color, text: activity.description)
                        TextShape(color: activity.color, text: activity.activityType.rawValue)
                        TextShape(color: activity.color, text: activity.timeTake)
                        
                            
                        
                        
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width)
                }.frame(width: UIScreen.main.bounds.width)
                
                
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
             
    }
}

struct TextShape: View {
    let color: Color
    let text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(height: 100)
                .opacity(0.6)
                
            Text(text)
                .font(.system(size: 25, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .opacity(0.8)
        }
        .padding()
        
    }
}

struct DetailActivity_Previews: PreviewProvider {
    static var previews: some View {
        DetailActivity(activity: Activity(activityName: "Walking", description: "no", timeTake: "1 hour", activityType: .other))
    }
}
