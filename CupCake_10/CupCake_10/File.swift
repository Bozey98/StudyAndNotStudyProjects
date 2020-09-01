//
//  File.swift
//  CupCake_10
//
//  Created by Денис Мусатов on 12.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import Foundation
import SwiftUI

class User: Codable, ObservableObject {
    enum CodingKeys: CodingKey {
        case name
    }
    @Published var name = "John Wick"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
