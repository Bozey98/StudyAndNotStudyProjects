//
//  PointInfo.swift
//  TestProject
//
//  Created by Денис Мусатов on 14.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

class PointInfo: ObservableObject {
    @Published var images: [LoadedImage]
    
    let urls = ["me", "newBG", "ex1", "ex2", "test", "telega"]
    
    init() {
        self.images = urls.map { LoadedImage($0)}
    }
    
}


class LoadedImage: ObservableObject, Identifiable {

    var id: String
    @Published var image: Image?
    
    init(_ id: String) {
        self.id = id
        self.image = Image(id)
    }
}
