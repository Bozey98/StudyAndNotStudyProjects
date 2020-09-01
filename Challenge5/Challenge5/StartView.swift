//
//  StartView.swift
//  Challenge5
//
//  Created by Денис Мусатов on 19.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("You are welcome")
                    .font(.largeTitle)
                Spacer()
                NavigationLink(destination: ContentView()) {
                    Text("Start").font(.title)
                        .padding()
                }
            }
           // .navigationBarTitle("", displayMode: .inline)
           // .navigationBarHidden(true)
        
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
