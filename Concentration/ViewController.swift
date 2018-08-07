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
    
    func cardInit(){
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        scoreCount = 2
        emojichoices = themeDict[selectTheme]!.themeContent
        updateViewFromModel()
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
    
    var scoreCount = 2 {
        didSet {
            scoreLabel.text="Score:\(scoreCount)"
        }
    }
    
    struct Theme {
        var themeName = ""
        var themeContent=[""]
    }
    var themeIdentifier = 8
    var themeDict:[Int:Theme] = [0:Theme(themeName: "Expression", themeContent: ["😀","😆","☺️","😅","😂","🤣","😇","😍","😝"]),1:Theme(themeName: "Animal", themeContent: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨"]),2:Theme(themeName: "Food", themeContent: ["🍏","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🥝"]),3:Theme(themeName: "Activity", themeContent: ["⚽️","🏀","🏈","⚾️","🎾","🏐","🎱","🏓","🏸"]),4:Theme(themeName: "Travel", themeContent: ["🚗","🚎","🏎","🚓","🚑","🚒","🚐","🚚","🚛"]),5:Theme(themeName: "Object", themeContent: ["⌚️","📱","💻","⌨️","🖥","🖨","🖱","🖲","🕹"]),6:Theme(themeName: "Symbol", themeContent: ["💟","☮️","✝️","☪️","🕉","☸️","✡️","🔯","🕎"]),7:Theme(themeName: "Flag", themeContent: ["🇧🇹","🇧🇫","🇧🇮","🇰🇵","🇬🇶","🇩🇰","🇩🇪","🇹🇱","🇹🇬"])]
    var selectTheme = 0
    var emojichoices = ["😀","😆","☺️","😅","😂","🤣","😇","😍","😝"]
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount+=1
        if let cardNumber=cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            scoreCount -= game.cards[cardNumber].penalizing
            updateViewFromModel();
            print("cardNumber = \(cardNumber)\t\(game.cards[cardNumber].identifier)\(cardButtons[cardNumber].currentTitle!)")
        }else{
            print("the card selected is not in the cardButtons")
        }
        
        //flipCountLabel.text="Flip:\(flipCount)"
//        flipCard(withEmoji: "🤨", on: sender)
//        print("Hummmm...")
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        cardInit()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
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
//                scoreCount -= card.isMatched ? 0 : 1
            }
//            print("Debug:\t\(cardButtons[index].currentTitle!)\t\(game.cards[index].identifier)")
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
        return themeDict.count
    }
    
    //设置选择框中各选项的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return themeDict[row]!.themeName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(component)
//        print(row)
        selectTheme = row
        themePickView.isHidden = true
//        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
//        flipCount = 0
//        emojichoices = themeDict[selectTheme]!.themeContent
//        updateViewFromModel()
        cardInit()
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
