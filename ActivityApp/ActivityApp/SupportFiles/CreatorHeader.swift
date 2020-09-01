//
//  CreatorHeader.swift
//  ActivityApp
//
//  Created by Денис Мусатов on 07.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct CreatorHeader: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        
            ZStack {
                Image("ImageApp")
                    .resizable()
                    .scaledToFill()
                    
                    
                VStack {
                    Spacer()
                    Text("Create Your Activity")
                        .foregroundColor(.white)
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .padding(30)
                }
                    
                    
                
            }
            .frame(height: self.screenHeight / 3)
            .shadow(radius: 20)

    }
}

struct CreatorHeader_Previews: PreviewProvider {
    static var previews: some View {
        CreatorHeader()
    }
}
