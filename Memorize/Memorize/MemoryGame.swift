//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Eren Özten on 7.02.2025.
//

import Foundation

struct MemoryGame<CardContent>{
    
    private(set) var cards: Array<Card>
    
    func choose(card: Card)
    {
        
    }
    
    struct Card
    {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
