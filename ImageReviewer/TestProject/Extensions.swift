//
//  Extensions.swift
//  TestProject
//
//  Created by Денис Мусатов on 14.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

extension Image {
    func squadClipped() -> some View {
        self
        .resizable()
        .scaledToFill()
        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

extension View {
    func squadClipped() -> some View {
        self
        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .padding(2)
        .shadow(radius: 1)
    }
}
