//
//  ViewController.swift
//  SlotMachine
//
//  Created by Tim on 10/8/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let views:[UIView] = [UIView(), UIView(), UIView(), UIView()]           // let makes the array immutable
    private let creditsLabel = UILabel()                                            // ...but not properties of object: mutable: A
    private let betLabel = UILabel()
    private let winnerPaidLabel = UILabel()
    
    private let resetButton = UIButton()
    private let spinButton = UIButton()
    
    private var slots:[[Slot]] = []
    private var slotImageViews:[[UIImageView]] = []
    
    // Score
    private var credits = 0
    private var currentBet = 0
    private var winnings = 0

    private let spinViews:[UIView] = [UIView(), UIView(), UIView()]
    private var winViews:[WinViewStruct] = []                               // instance of as-yet undefined: n-pass compilation like JS

    private struct WinViewStruct
    {
        var view = UIView()
        var label = UILabel()
        var outline = UILabel()
        
        init(container:UIView, yOff:Int)
        {
            let labelSize:CGFloat = 80
            let fontName = "MarkerFelt-Wide"
            
            label.textColor = UIColor.yellowColor()
            label.font = UIFont(name: fontName, size: labelSize)
            outline.textColor = UIColor.blackColor()
            outline.font = UIFont(name: fontName, size: labelSize+10)
            outline.backgroundColor = UIColor(red: 0.2, green: 1, blue: 0.2, alpha: 0.4)
            view.addSubview(outline)                                        // Seems to set Z-order
            view.addSubview(label)
            view.frame = container.bounds
            
            let height = view.frame.size.height / CGFloat(kNumSlots)
            view.frame.size.height = height
            view.frame.origin.y += CGFloat(yOff) * height
            
            view.backgroundColor = UIColor(white: 0, alpha: 0)
            view.transform = CGAffineTransformMakeScale(0, 0)
            container.addSubview(view)
        }

        func setText(text:String)
        {
            func setText_A(label:UILabel)
            {
                label.text = text
                label.sizeToFit()
                label.center = view.center
            }
            
            setText_A(label)
            setText_A(outline)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        let titleLabel = UILabel()
        titleLabel.text = "Super Slots"                                // A        mutable let object
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
        
    // Second view win views to show    Flush!    + 1!      expanding outward
        for var ixSlot = 0; ixSlot < kNumSlots; ++ixSlot
        {
            winViews.append(WinViewStruct(container: secondView, yOff: ixSlot))
        }

    // Third view: Score
        let thirdView = views[2]
        
        func SetLabel(label:UILabel)
        {
            label.font = UIFont(name: "Menlo-Bold", size: 16)
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.redColor()
            label.backgroundColor = UIColor.blackColor()
            label.center.y = thirdView.frame.height/3
            thirdView.addSubview(label)                                     //  closure
        }
        
        SetLabel(self.creditsLabel)
        SetLabel(betLabel)
        SetLabel(winnerPaidLabel)
        
        // second func just to demo/test
        func SetLabel_A(label:UILabel, pos:CGFloat = 1)  // opt param; cannot overload embed func
        {
            label.text = "000000"       // sets min width
            label.sizeToFit()
            label.center.x = thirdView.frame.width/6 * pos
        }
        
        SetLabel_A(creditsLabel)
        SetLabel_A(betLabel, pos:3)                            // must have opt argument specifier
        SetLabel_A(winnerPaidLabel, pos:5)
        
    // Third view title labels
        func SetTitleLabel(text:NSString, label:UILabel = UILabel(), pos:CGFloat = 1)
        {
            label.font = UIFont(name: "AmericanTypeWriter", size: 14)
            label.textColor = UIColor.blackColor()
            label.center.y = thirdView.frame.height/3 * 2
            thirdView.addSubview(label)
            
            label.text = text
            label.sizeToFit()
            label.center.x = thirdView.frame.width/6 * pos
        }
        
        SetTitleLabel("Credits")
        SetTitleLabel("Bet", pos:3)
        SetTitleLabel("Winner Paid", pos:5)
        
    // Fourth view: Buttons
        func SetButton(text:NSString, backColor:UIColor, callback:Selector, button:UIButton = UIButton(), pos:CGFloat = 1)
        {
            let fourthView = self.views[3]
            
            button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
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
        SetButton("Reset", UIColor.lightGrayColor(), "resetButtonPressed:", button:self.resetButton)
        SetButton("Bet One", UIColor.greenColor(), "betOneButtonPressed:", pos:3)
        SetButton("Bet Max", UIColor.redColor(), "betMaxButtonPressed:", pos:5)
        SetButton("Spin", UIColor.greenColor(), "spinButtonPressed:", button:spinButton, pos:7)
    }
    
    private func updateScore()
    {
        creditsLabel.text = "$\(credits)"
        betLabel.text = "$\(currentBet)"
        winnerPaidLabel.text = "$\(winnings)"
    }
    
    private var alerting = false
    private var alerts:[(String, String)] = []
    private var callback_A:(() -> Void)! = nil
    
    private func alert(header: String = "Whoops!", message: String, callback:(() -> Void)! = nil)        // Optional parameter must be last or spec param
    {
        if (alerting)
        {
            alerts.append((header, message))
        }
        else
        {
            alerting = true
            
            if (callback != nil)
            {
                callback_A = callback
            }
            
            let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:
            {
                (alert: UIAlertAction!) in self.nextAlert()
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func nextAlert()
    {
        self.alerting = false       // will toggle very quickly when popping from stack
        
        if (self.alerts.count > 0)
        {
            var msg = self.alerts[0]
            
            self.alerts.removeAtIndex(0)
            self.alert(header:msg.0, message:msg.1)
        }
        else
        {
            if (callback_A != nil)
            {
                var callback = callback_A
                callback_A = nil
                callback()
            }
        }
    }
    
    private func testCredits() -> Bool
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        resetButton.sendAction("resetButtonPressed:", to: nil, forEvent: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtonPressed(button:UIButton)                            // Selector targets cannot be private
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
    
    private func animateText(winview:WinViewStruct, strings:[String], ixStr:Int = 0)
    {
        if (strings.count <= ixStr)
        {
            return;
        }
        
        winview.setText(strings[ixStr])
        var view = winview.view
        
        UIView.animateWithDuration(1, delay:0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                view.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { finished in
                view.transform = CGAffineTransformMakeScale(0, 0)
                self.animateText(winview, strings: strings, ixStr:ixStr + 1)
            }
        )
    }
    
    private var wins = Factory.WinsStruct()
    
    private func animateCards()
    {
        func animateCard(view:UIImageView, delay:NSTimeInterval = 0)
        {
            UIView.animateWithDuration(0.5, delay:delay,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { //() -> Void in     //   what; why optional
                    view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                }, completion: { finished in
                    view.transform = CGAffineTransformMakeRotation(0)
                }
            )
        }
        
        if (wins.any.count > 0)
        {
            for var deixSlot = 0; deixSlot < wins.any.count; ++deixSlot
            {
                var ixSlot = wins.any[deixSlot]
                
                for var ixCol = 0; ixCol < kNumCols; ++ixCol
                {
                    animateCard(slotImageViews[ixCol][ixSlot], delay: NSTimeInterval(Float(ixCol) * 0.2))
                }
                
                var strings = ["Flush!", "Bet 1", "+ 1"]
                animateText(winViews[ixSlot], strings: strings)
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
            wins = Factory.findWins(slots)
            winnings = 0
            
            func computeAndShow(win:[Int], mult:Int, allWin:Int, won1s:String, wonAllS:String) -> Int
            {
                if (win.count > 0)
                {
                    let winMult = win.count * mult

                    alert(header: won1s, message: "\(win.count)x.  Bet $\(self.currentBet)  Won $\(winMult * self.currentBet)", callback:animateCards)
                    
                    winnings += winMult
                    
                    if (win.count == kNumSlots)
                    {
                        alert(header: wonAllS, message: "$\(allWin) per bet.  Bet $\(self.currentBet)  Won $\(allWin * self.currentBet)")
                        winnings += allWin
                        
                        return 2
                    }
                    
                    return 1
                }
                
                return 0
            }
            
            var numTypesOfWin = computeAndShow(wins.flushes, 1, 25, "Flush!", "Royal Flush!")
            numTypesOfWin += computeAndShow(wins.xsInArow, 1, 1000, "Straight!", "Epic Straight!")
            numTypesOfWin += computeAndShow(wins.xsOfAkind, 3, 50, "\(kNumCols) of a Kind!", "\(kNumCols)'s All 'Round!")
            
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

