//
//  ContentView.swift
//  HackingWithSwift3
//
//  Created by Денис Мусатов on 27.05.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var color = false
    
    var body: some View {
        Text("Dfsdfsd").denizle()
    }
    
    
}

struct Denizle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func denizle() -> some View {
        self.modifier(Denizle())
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
