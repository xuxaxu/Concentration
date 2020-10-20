//
//  ViewController.swift
//  Concentration
//
//  Created by Ксения Каштанкина on 07.01.2020.
//  Copyright © 2020 Ксения Каштанкина. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    
    
    private lazy var game: Concentration = Concentration(countOfPairsOfCards: countOfPairsOfCards)
    
    var countOfPairsOfCards : Int {
        get {
            return (gameCards.count + 1)/2
        }
    }
    private var flipCard: Int = 0 {
        didSet {
            updateFlipText()
        }
    }
    
    private func updateFlipText() {
        let attributes : [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attrText = NSAttributedString(string: "Flips: \(flipCard)", attributes: attributes)
        flipLabel.attributedText = attrText
    }
    
    @IBOutlet weak private var flipLabel: UILabel! {
        didSet {
            updateFlipText()
        }
    }
    
    @IBOutlet private var gameCards: Array<UIButton>!
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "👻🎃☠️👹🥶😈💀🤑🤡💩😵🤖👣👀👁👩🏿‍🦰🧕🏾👩🏻‍🎤👨🏻‍🍳👩🏽‍🏭👩🏻‍🦼👯‍♂️🕸🌜🌚⭐️🔥🌈❄️☃️🤸🏼‍♀️🧘🏿🚴🏽‍♂️🎭🧩🚀🕹💉🦠🎎🧸🔯☢️❌♠️🏳️‍🌈👊🏼🐒🦆"
    
    private var emoji = [Card : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if game.finGame {
            game = Concentration(countOfPairsOfCards: Int(gameCards.count / 2))
            flipCard = 0
            updateViewFromModel()
        } else {
            if let cardNumber = gameCards.firstIndex(of: sender) {
            flipCard += 1
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            }
        }
    }
    
    private func updateViewFromModel() {
           
        if gameCards != nil {
        
        for index in gameCards.indices {
            let button = gameCards[index]
            let card = game.cards[index]
            if card.isFacesUp && (!card.isMathed) {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMathed ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let choosenEmojiIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: Int(emojiChoices.count.randomInt))
            let choosenEmoji = emojiChoices.remove(at:  choosenEmojiIndex)
            emoji[card] = String(choosenEmoji)
        }
        return emoji[card] ?? "?"
    }
    
    private func showSmth() {
         flipLabel.text = "Win!"
        for button in gameCards {
            let em = emoji(for: game.cards[gameCards.firstIndex(of: button)!])
            button.setTitle(em, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
}

extension Int  {
    var randomInt: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
   }
