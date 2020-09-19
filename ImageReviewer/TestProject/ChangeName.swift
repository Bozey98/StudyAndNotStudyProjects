//
//  ChangeName.swift
//  KekMemTestProj
//
//  Created by Денис Мусатов on 09.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ChangeName: View {
    @EnvironmentObject var mem: ViewRouter
    @State var user: User
    
    var body: some View {
        VStack {
            TextField("Name", text: $user.name)
        }.onDisappear(perform: {
            
        })
    }
}

//struct ChangeName_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeName(user: User(name: "mem"))
//    }
//}



