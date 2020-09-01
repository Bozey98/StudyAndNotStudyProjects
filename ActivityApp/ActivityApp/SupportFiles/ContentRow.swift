//
//  ContentRow.swift
//  ActivityApp
//
//  Created by Денис Мусатов on 07.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentRow: View {
    
    let activity: Activity
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(self.colorChoice())
                    .shadow(radius: 8)
                HStack {
                    Text(self.activity.activityName)
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                        .bold()
                        
                    Spacer()
                    
                    Text(self.activity.timeTake)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                }.padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: geo.size.height / 10)
            .padding()
        
        }
    }
    
    func colorChoice() -> Color {
        switch activity.activityType {
            case .education:
                return Color.green
            case .homeWork:
                return Color.yellow
            case .sport:
                return Color.blue
            case .other:
                return Color.purple
        }
    }
}

struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow(activity: Activity(activityName: "Nothing", description: "no", timeTake: "1 hour", activityType: .other))
    }
}
