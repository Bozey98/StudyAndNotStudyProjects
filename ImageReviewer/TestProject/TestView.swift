//
//  TestView.swift
//  TestProject
//
//  Created by Денис Мусатов on 28.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct Test1View: View {
    var body: some View {
        Button("Say Hello") {
            print("Hello")
        }
    }
}

struct Test1View_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
