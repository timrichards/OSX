//
//  Factory.swift
//  SlotMachine
//
//  Created by Tim on 10/9/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import UIKit
import Foundation

let kNumCols = 3
let kNumSlots = 3

struct Slot
{
    var value = 0
    var image = UIImage(named:"")
    var isRed = true
}

class Factory
{
    class func createSlots() -> [[Slot]]
    {
        var slots:[[Slot]] = []
        
        for var ixCol = 0; ixCol<kNumCols; ++ixCol
        {
            slots.append([])
            
            for var ixSlot = 0; ixSlot<kNumSlots; ++ixSlot
            {
                slots[slots.count-1].append(Factory.createSlot(slots[slots.count-1]))
            }
        }
        
        return slots
    }
    
    class func createSlot(currentCards:[Slot]) -> Slot
    {
        var currentCardValues:[Int] = []
        
        for slot in currentCards
        {
           currentCardValues.append(slot.value)
        }
        
        var randomCard:Int
        
        do
        {
            randomCard = Int(arc4random_uniform(13)) + 1        // One through Thirteen
        }
        while contains(currentCardValues, randomCard)
        
        let cardNames:[NSString] = ["ERROR",
            "Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
            "Jack", "Queen", "King"]
        
        let redness:[Bool] = [true,
            true, true, true, true, false, false, true, false, false, true,
            false, false, true]
        
        return Slot(value: randomCard, image: UIImage(named:cardNames[randomCard]), isRed: redness[randomCard])
    }
}

