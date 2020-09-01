//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Денис Мусатов on 25.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

//func createContent(pairIndex: Int) -> String {
//  let emojis: [String] = ["👻","🎃","🕷"]
//  return emojis[pairIndex]
//}

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemeryGame()
        
    private static func createMemeryGame() -> MemoryGame<String> {
        let emojis: [String] = ["👻","🎃","🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemeryGame()
    }
}
