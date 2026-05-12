//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eren Özten on 7.02.2025.
//

import SwiftUI

class EmojiMemoryGame {
    private var model: MemoryGame<String>
    
    
    var cards : Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // choose bir 'intent function' dır
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
