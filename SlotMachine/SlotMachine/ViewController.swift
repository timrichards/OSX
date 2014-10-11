//
//  ViewController.swift
//  SlotMachine
//
//  Created by Tim on 10/8/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let views:[UIView] = [UIView(), UIView(), UIView(), UIView()]           // let makes the array immutable
    let titleLabel = UILabel()                                              // ...but not properties of object: mutable: A
    let creditsLabel = UILabel()
    let betLabel = UILabel()
    let winnerPaidLabel = UILabel()
    let creditsTitleLabel = UILabel()
    let betTitleLabel = UILabel()
    let winnerPaidTitleLabel = UILabel()
    
    let resetButton = UIButton()
    let betOneButton = UIButton()
    let betMaxButton = UIButton()
    let spinButton = UIButton()
    
    var slots:[[Slot]] = []
    var slotImageViews:[[UIImageView]] = []
    
    // Score
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    private func createViews()
    {
        1 + 1                                                               // no lvalue builds just fine

        let kSumHeights:CGFloat = 6
        let heights:[CGFloat] = [1, 3, 1, 1]
        let colors:[UIColor] = [UIColor.redColor(), UIColor.blackColor(), UIColor.lightGrayColor(), UIColor.blackColor()]

        let kMarginForView:CGFloat = 10
        var yOffset:CGFloat = 0
        
        for (i, view) in enumerate(views)
        {
            view.frame.origin.x = self.view.bounds.origin.x + kMarginForView
            view.frame.size.width = self.view.bounds.width - (2*kMarginForView)
            
            let height = self.view.bounds.height/kSumHeights * heights[i]
            view.frame.size.height = height
            
            //Vertical positioning is offset
            view.frame.origin.y = yOffset
            yOffset += height
            
            view.backgroundColor = colors[i]
            self.view.addSubview(view)
        }
        
    // First view: Title
        self.titleLabel.text = "Super Slots"                                // A        mutable let object
        titleLabel.textColor = UIColor.yellowColor()
        titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        titleLabel.sizeToFit()
        titleLabel.center = views[0].center
        views[0].addSubview(titleLabel)
        
    // Second view: largest: Slots
        let kColMargin:CGFloat = 4
        let kSlotMargin:CGFloat = 2
        let secondView = views[1]
        
        for var ixCol = 0; ixCol < kNumCols; ++ixCol          // kNumCols; kNumSlots are in Factory.swift
        {
            slotImageViews.append([])
            
            for var ixSlot = 0; ixSlot < kNumSlots; ++ixSlot
            {
                var slotImageView = UIImageView()
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame.origin.x = secondView.bounds.origin.x + secondView.bounds.size.width * CGFloat(ixCol)/CGFloat(kNumCols)
                slotImageView.frame.origin.y = secondView.bounds.origin.y + secondView.bounds.size.height * CGFloat(ixSlot)/CGFloat(kNumSlots)
                slotImageView.frame.size.width = secondView.bounds.width/CGFloat(kNumCols) - kColMargin
                slotImageView.frame.size.height = secondView.bounds.height/CGFloat(kNumSlots) - kSlotMargin
                
                // even the overall border, if not removing it
                slotImageView.frame.origin.x += kColMargin/2
                slotImageView.frame.origin.y += kSlotMargin/2
                secondView.addSubview(slotImageView)
                
                slotImageViews[slotImageViews.count-1].append(slotImageView)
            }
        }
        
    // Third view: Score
        let thirdView = views[2]
        
        func SetLabel(label:UILabel)
        {
            label.font = UIFont(name: "Menlo-Bold", size: 16)
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.redColor()
            label.backgroundColor = UIColor.darkGrayColor()
            label.center.y = thirdView.frame.height/3
            thirdView.addSubview(label)                                     //  closure
        }
        
        SetLabel(self.creditsLabel)
        SetLabel(betLabel)
        SetLabel(winnerPaidLabel)
        
        // second func just to demo/test
        func SetLabel_A(label:UILabel, text:NSString = "000000", pos:CGFloat = 1)  // opt param; cannot overload embed func
        {
            label.text = text
            label.sizeToFit()
            label.center.x = thirdView.frame.width/6 * pos
        }
        
        SetLabel_A(creditsLabel)
        SetLabel_A(betLabel, text:"0000", pos:3)                            // must have opt argument specifier
        SetLabel_A(winnerPaidLabel, pos:5)
        
    // Third view title labels
        func SetTitleLabel(label:UILabel, text:NSString, pos:CGFloat = 1)
        {
            label.font = UIFont(name: "AmericanTypeWriter", size: 14)
            label.textColor = UIColor.blackColor()
            label.center.y = thirdView.frame.height/3 * 2
            thirdView.addSubview(label)
            
            label.text = text
            label.sizeToFit()
            label.center.x = thirdView.frame.width/6 * pos
        }
        
        SetTitleLabel(self.creditsTitleLabel, "Credits")
        SetTitleLabel(betTitleLabel, "Bet", pos:3)
        SetTitleLabel(winnerPaidTitleLabel, "Winner Paid", pos:5)
        
    // Fourth view: Buttons
        func SetButton(button:UIButton, text:NSString, backColor:UIColor, callback:Selector, pos:CGFloat = 1)
        {
            let fourthView = self.views[3]
            
            button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
            button.center.y = fourthView.frame.height/2
            fourthView.addSubview(button)
 
            button.setTitle(text, forState: UIControlState.Normal)
            button.sizeToFit()
            button.backgroundColor = backColor
            button.center.x = fourthView.frame.width/8 * pos
            button.addTarget(self, action: callback, forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        // Build will succeed with functions undefined for given selectors
        SetButton(self.resetButton, "Reset", UIColor.lightGrayColor(), "resetButtonPressed:")
        SetButton(betOneButton, "Bet One", UIColor.greenColor(), "betOneButtonPressed:", pos:3)
        SetButton(betMaxButton, "Bet Max", UIColor.redColor(), "betMaxButtonPressed:", pos:5)
        SetButton(spinButton, "Spin", UIColor.greenColor(), "spinButtonPressed:", pos:7)
    }
    
    func updateScore()
    {
        creditsLabel.text = "$\(credits)"
        betLabel.text = "$\(currentBet)"
        winnerPaidLabel.text = "$\(winnings)"
    }
    
    var alerting = false
    var alerts:[(String, String)] = []
    
    func alert(header: String = "Warning", message: String)        // Example of optional parameter not being last
    {
        if (alerting)
        {
            alerts.append((header, message))
        }
        else
        {
            alerting = true
            
            let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:
            {
                (alert: UIAlertAction!) in self.nextAlert()
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func nextAlert()
    {
        self.alerting = false       // will toggle very quickly when popping from stack
        
        if (self.alerts.count > 0)
        {
            var msg = self.alerts[0]
            
            self.alerts.removeAtIndex(0)
            self.alert(header:msg.0, message:msg.1)
        }
    }
    
    func testCredits() -> Bool
    {
        if (credits <= 0)
        {
            if (currentBet <= 0)
            {
                self.alert(header: "No more credits!", message: "Reset game.")
                resetButton.sendAction("resetButtonPressed:", to: nil, forEvent: nil)
            }
        }
        else if (currentBet >= 5)
        {
            self.alert(message: "You can only bet 5 credits at a time.")
        }
        else
        {
            return true
        }
        
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        resetButton.sendAction("resetButtonPressed:", to: nil, forEvent: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtonPressed(button:UIButton)
    {
        credits = 5
        winnings = 0
        currentBet = 1
        updateScore()
        spinButton.sendAction("spinButtonPressed:", to: nil, forEvent: nil)
    }
    
    func betOneButtonPressed(button:UIButton)
    {
        
        if (testCredits())
        {
            --credits
            ++currentBet
            updateScore()
        }
    }
    
    func betMaxButtonPressed(button:UIButton)
    {
        if (testCredits())
        {
            if (credits < 5)
            {
                self.alert(header: "Not enough credits!", message: "Bet less.")
            }
            else
            {
                let creditsToBetMax = 5 - currentBet
                
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateScore()
            }
        }
    }
    
    func spinButtonPressed(button:UIButton)
    {
        slots = Factory.createSlots()
        
        for var ixCol = 0; ixCol < kNumCols; ++ixCol          // kNumCols; kNumSlots are in Factory.swift
        {
            for var ixSlot = 0; ixSlot < kNumSlots; ++ixSlot
            {
                slotImageViews[ixCol][ixSlot].image = slots[ixCol][ixSlot].image
            }
        }
        
        if (currentBet > 0)
        {
            var wins = Factory.findWins(slots)
            winnings = 0
            
            func computeAndShow(win:Int, mult:Int, allWin:Int, won1s:String, wonAllS:String) -> Int
            {
                if (win > 0)
                {
                    let winMult = win * mult

                    alert(header: won1s, message: "\(win)x.  Bet $\(self.currentBet)  Won $\(winMult * self.currentBet)")
                    winnings += winMult
                    
                    if (win == kNumSlots)
                    {
                        alert(header: wonAllS, message: "$\(allWin) per bet.  Bet $\(self.currentBet)  Won $\(allWin * self.currentBet)")
                        winnings += allWin
                        
                        return 2
                    }
                    
                    return 1
                }
                
                return 0
            }
            
            var numTypesOfWin = computeAndShow(wins.0, 1, 25, "Flush!", "Royal Flush!")
            numTypesOfWin += computeAndShow(wins.1, 1, 1000, "Straight!", "Epic Straight!")
            numTypesOfWin += computeAndShow(wins.2, 3, 50, "\(kNumCols) of a Kind!", "\(kNumCols)'s All 'Round!")
            
            winnings *= currentBet
            
            if (numTypesOfWin > 1)
            {
                alert(header: "Total Wins!", message: "+ $\(winnings)")
            }
            
            credits += winnings
            currentBet = 0
            updateScore()
        }
    }
}

