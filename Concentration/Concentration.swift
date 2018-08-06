//
//  Concentration.swift
//  Concentration
//
//  Created by Xhandsome on 2018/4/30.
//  Copyright © 2018年 Xhandsome. All rights reserved.
//

import Foundation

class Concentration {
    var cards = Array<Card>()
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index:Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)):chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards:Int) {
        assert(numberOfPairsOfCards > 0,"Concentration.init(at: \(numberOfPairsOfCards):you must have at lease one pair of cards")
        for _ in 0...numberOfPairsOfCards{
            let card = Card()
//            cards+=[card,card]
            cards.insert(card, at: cards.count.arc4random)
            cards.insert(card, at: cards.count.arc4random)        }
    }
}
