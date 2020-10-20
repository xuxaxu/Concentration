//
//  Card.swift
//  Concentration
//
//  Created by Ксения Каштанкина on 22.01.2020.
//  Copyright © 2020 Ксения Каштанкина. All rights reserved.
//

import Foundation

struct Card: Hashable, Equatable {
    var isFacesUp = false
    var isMathed = false
    private var identifier: Int
    
    static func ==(_ card1 : Card, _ card2 : Card) -> Bool {
        return card1.identifier == card2.identifier
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
}
