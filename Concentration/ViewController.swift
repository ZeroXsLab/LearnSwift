//
//  ViewController.swift
//  Concentration
//
//  Created by Xhandsome on 2018/4/30.
//  Copyright © 2018年 Xhandsome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
    
    var flipCount=0{
        didSet {
            flipCountLabel.text="Flip:\(flipCount)"
        }
    }
    var emojichoices = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨"]
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber=cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel();
            print("cardNumber = \(cardNumber)\t")
        }else{
            print("the card selected is not in the cardButtons")
        }
        
        //flipCountLabel.text="Flip:\(flipCount)"
//        flipCard(withEmoji: "🤨", on: sender)
//        print("Hummmm...")
    }

    func updateViewFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card=game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card), for: UIControlState.normal)
                button.backgroundColor=#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor=card.isMatched ? #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    var emoji = [Int:String]()
    
    func emoji(for card:Card) -> String {
        if emoji[card.identifier] == nil , emojichoices.count > 0 {
                let randomIndex = Int( arc4random_uniform(UInt32(emojichoices.count)))
                emoji[card.identifier] = emojichoices.remove(at: randomIndex)
        }
//        if emoji[card.identifier] != nil{
//            return emoji[card.identifier]!
//        }
//        else{
//            return "?"
//        }
        //以上代码与下方语句等效
        return emoji[card.identifier] ?? "?"
    }
}

