//
//  ViewController.swift
//  Concentration
//
//  Created by Xhandsome on 2018/4/30.
//  Copyright © 2018年 Xhandsome. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themePickView.dataSource = self
        themePickView.delegate = self
        themePickView.isHidden = true
    }
    
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount=0{
        didSet {
            flipCountLabel.text="Flip:\(flipCount)"
        }
    }
    var emojichoices = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨"]
    let theme = ["Animal","Food","Activity"]
    let emojiArray = [["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨"],["🍏","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒"],["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱","🏓","🏸"]]
    var selectTheme = 0
    
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber=cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel();
            print("cardNumber = \(cardNumber)\t\(cardButtons[cardNumber].currentTitle!)")
        }else{
            print("the card selected is not in the cardButtons")
        }
        
        //flipCountLabel.text="Flip:\(flipCount)"
//        flipCard(withEmoji: "🤨", on: sender)
//        print("Hummmm...")
    }
    @IBAction func restartGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        emojichoices = emojiArray[selectTheme]
        updateViewFromModel()
    }
    
    @IBOutlet weak var themePickView: UIPickerView!
    
    @IBAction func changeTheme(_ sender: UIButton) {
        themePickView.isHidden = !themePickView.isHidden
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
//        if emoji[card.identifier] == nil , emojichoices.count > 0 {
//                let randomIndex = Int( arc4random_uniform(UInt32(emojichoices.count)))
//                emoji[card.identifier] = emojichoices.remove(at: randomIndex)
//        }
        if emoji[card.identifier] == nil , emojichoices.count > 0 {
            emoji[card.identifier] = emojichoices.remove(at: emojichoices.count.arc4random)
        }
        //以上代码与下方语句配套Extension等效
        
//        if emoji[card.identifier] != nil{
//            return emoji[card.identifier]!
//        }
//        else{
//            return "?"
//        }
        //以上代码与下方语句等效
        return emoji[card.identifier] ?? "?"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return theme.count
    }
    
    //设置选择框中各选项的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return theme[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component)
        print(row)
        selectTheme = row
        themePickView.isHidden = true
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        emojichoices = emojiArray[selectTheme]
        updateViewFromModel()
    }
}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }else {
            return 0
        }
    }
}
