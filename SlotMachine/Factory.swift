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
    
    typealias WinsType = ([Int], [Int], [Int])
    class func winsTypeInit() -> WinsType { return ([0], [0], [0]) }

    class func findWins(slots:[[Slot]]) -> WinsType
    {
        var flushes:[Int] = []
        var xsInArow:[Int] = []
        var xsOfAkind:[Int] = []
        
        for var nSlot = 0; nSlot < kNumSlots; ++nSlot
        {
            var isRed = slots[0][nSlot].isRed
            var isFlush = true
            
            if (isRed != slots[1][nSlot].isRed)
            {
                isFlush = false
            }
            
            var trajXinARow = slots[1][nSlot].value - slots[0][nSlot].value
            var isXinArow = false
            
            if (abs(trajXinARow) == 1)
            {
                isXinArow = true
            }
            
            var nXofAkind = slots[0][nSlot].value
            var isXofAkind = true
            
            for var nCol = 1; nCol < kNumCols; ++nCol
            {
                if (isFlush && (isRed != slots[nCol][nSlot].isRed))
                {
                    isFlush = false
                }
                
                if ((nCol > 1) && isXinArow && (trajXinARow != slots[nCol][nSlot].value - slots[nCol-1][nSlot].value))
                {
                    isXinArow = false
                }
                
                if (isXofAkind && (nXofAkind != slots[nCol][nSlot].value))
                {
                    isXofAkind = false
                }
            }
            
            if (isFlush)
            {
                flushes.append(nSlot)
            }
            
            if (isXinArow)
            {
                xsInArow.append(nSlot)
            }
            
            if (isXofAkind)
            {
                xsOfAkind.append(nSlot)
            }
        }
        
        return (flushes, xsInArow, xsOfAkind)
    }
}

