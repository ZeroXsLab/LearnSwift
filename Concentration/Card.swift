//
//  Card.swift
//  Concentration
//
//  Created by Xhandsome on 2018/4/30.
//  Copyright © 2018年 Xhandsome. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    static var identifierFactory = 0
    
    static func getIdentifier() -> Int{
        identifierFactory += 1;
        return Card.identifierFactory
    }
    init() {
        self.identifier=Card.getIdentifier()
    }
    
}
