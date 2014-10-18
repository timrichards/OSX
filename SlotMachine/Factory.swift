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
let kNumWinTypes = 3

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
    
    struct WinsStruct
    {
        var any:[Int] = []
        
        var xsOfAkind:[Int] = []    // kNumWinTypes kinds of wins
        var xsInArow:[Int] = []
        var flushes:[Int] = []
        
        var orth:[[Bool]] = []
        
        init()
        {
            for var i = 0; i < kNumSlots; ++i
            {
                orth.append([false, false, false])  // kNumWinTypes kinds of wins. Bool can be represented as 0 and not 0
            }
        }
        
        struct WinReports
        {
            // struct vars aren't vars: assigned when creating instance.
            // struct inits don't work: e.g. vars are never given a value
            var mult:Int
            var all:Int
            var strOne:String
            var strAll:String
        }
        
        // kNumWinTypes kinds of wins
        // classes can't have static vars but structs can. Does let consume n instances more resources than static let?
        static let xOfAkindReport = WinReports(mult: 3, all: 50, strOne: "\(kNumCols) of a Kind!", strAll: "\(kNumCols)'s All 'Round!")
        static let straightReport = WinReports(mult: 1, all: 1000, strOne: "Straight!", strAll: "Epic Straight!")
        static let flushReport = WinReports(mult: 1, all: 25, strOne: "Flush!", strAll: "Royal Flush!")
        static let reports = [xOfAkindReport, straightReport, flushReport]
        
        static func getAnimateText(ixWin:Int, bet:Int) -> [String]
        {
            let report = Factory.WinsStruct.reports[ixWin]       // must reference internal static vars as though external
            var strings = [report.strOne, "Bet $\(bet)"]
            
            if (report.mult > 1)
            {
                strings.append("\(report.mult) X")
            }
            
            strings.append("Won $\(bet * report.mult)")
            return strings
        }
    }

    class func findWins(slots:[[Slot]]) -> WinsStruct
    {
        var wins = WinsStruct()
        
        for var nSlot = 0; nSlot < kNumSlots; ++nSlot
        {
        // X of a Kind
            var nXofAkind = slots[0][nSlot].value
            var isXofAkind = true
            
        // Straight
            var trajXinARow = slots[1][nSlot].value - slots[0][nSlot].value
            var isXinArow = false
            
            if (abs(trajXinARow) == 1)
            {
                isXinArow = true
            }
            
        // Flush
            var isRed = slots[0][nSlot].isRed
            var isFlush = true
            
            if (isRed != slots[1][nSlot].isRed)
            {
                isFlush = false
            }
            
            for var nCol = 1; nCol < kNumCols; ++nCol
            {
                if (isXofAkind && (nXofAkind != slots[nCol][nSlot].value))
                {
                    isXofAkind = false
                }
                
                if ((nCol > 1) && isXinArow && (trajXinARow != slots[nCol][nSlot].value - slots[nCol-1][nSlot].value))
                {
                    isXinArow = false
                }
                
                if (isFlush && (isRed != slots[nCol][nSlot].isRed))
                {
                    isFlush = false
                }
            }
            
            if (isXofAkind)
            {
                wins.xsOfAkind.append(nSlot)
                wins.orth[nSlot][0] = true
            }
            
            if (isXinArow)
            {
                wins.xsInArow.append(nSlot)
                wins.orth[nSlot][1] = true
            }
            
            if (isFlush)
            {
                wins.flushes.append(nSlot)
                wins.orth[nSlot][2] = true
            }
            
            if (isXofAkind || isXinArow || isFlush)
            {
                wins.any.append(nSlot)
            }
        }
        
        return wins
    }
}

