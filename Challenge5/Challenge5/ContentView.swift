//
//  ContentView.swift
//  Challenge5
//
//  Created by Денис Мусатов on 19.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let users = Users()
    
    var body: some View {
            VStack {
                List {
                    ForEach(users.users) { user in
                        NavigationLink(destination: DetailView(user: user)) {
                            Text(user.name)
                        }
                    }
                }
                
            
            .navigationBarTitle("Users List", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
