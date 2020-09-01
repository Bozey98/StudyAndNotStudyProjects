//
//  User.swift
//  Challenge5
//
//  Created by Денис Мусатов on 19.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    let id : String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    var online : String {
        isActive ? "online" : "offline"
    }
    
}


struct Friend: Codable, Identifiable {
    let id: String
    let name: String
}


class Users: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        print("sss")
        if let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") {
            
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let decoded = try? decoder.decode([User].self, from: data) {
                        
                        self.users = decoded
                        return
                    }
                    else {
                        print("Decode")
                    }
                } else {
                    print("Nil data")
                }
                
            }.resume()
        } else {
            print("URL")
        }
    }
}
