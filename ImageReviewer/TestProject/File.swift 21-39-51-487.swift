//
//  File.swift
//  KekMemTestProj
//
//  Created by Денис Мусатов on 09.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Users: ObservableObject {
    @Published var users = [User(name: "mem"), User(name: "kek")]
}

//class Users: ObservableObject {
//    @Published var users: [User]
//
//    init() {
//        users = [User(name: "Hui"), User(name: "Mem"), User(name: "Hoh")]
//    }
//}
