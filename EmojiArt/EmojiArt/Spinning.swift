//
//  Spinning.swift
//  EmojiArt
//
//  Created by Денис Мусатов on 07.07.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct Spinnig: ViewModifier {
    
    @State var isVisible: Bool = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isVisible ? 360: 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                self.isVisible = true
            }
    }
}

extension View {
    func spinning() ->  some View {
        self.modifier(Spinnig())
    }
}


