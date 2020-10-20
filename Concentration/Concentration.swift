//
//  Concentration.swift
//  Concentration
//
//  Created by Ксения Каштанкина on 22.01.2020.
//  Copyright © 2020 Ксения Каштанкина. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = Array<Card>()
    
    private var indexOfOneFacedUp: Int? {
        get {
            return cards.indices.filter {
                 cards[$0].isFacesUp
            }.onlyOne
        }
        set {
            for index in cards.indices {
                cards[index].isFacesUp = (index == newValue)
            }
        }
    }
    
    var finGame = false
    
    mutating func chooseCard(at index:Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index): the index not in cards indices")
        if !cards[index].isMathed {
            if let matchedIndex = indexOfOneFacedUp, matchedIndex != index {
                if cards[matchedIndex] == cards[index] {
                    cards[index].isMathed = true
                    cards[matchedIndex].isMathed = true
                    var amountOfMatched = 0
                    for eachCard in cards {
                        if eachCard.isMathed {
                            amountOfMatched += 1
                        }
                    }
                    if amountOfMatched == cards.count {
                        finGame = true
                    }
                } else {
                    cards[index].isFacesUp = true
                }
            } else {
                indexOfOneFacedUp = index
            }
        }

    }
    
    init(countOfPairsOfCards: Int) {
        assert(countOfPairsOfCards>0, "Concentration initializaton: count of pairs of cards must be positive")
        for _ in 1...countOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //shuffle
        cards.shuffle()
    
    }
}

extension Collection {
    var onlyOne: Element? {
        return count == 1 ? first : nil
    }
}
