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
        
    // Fourth view: Butttons                                                                 opt args must be last if op'd
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createViews()
        Factory.createSlots()
    //    Factory().createSlot(slotArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtonPressed(button:UIButton)
    {
        println(button)
    }
    
    func betOneButtonPressed(button:UIButton)
    {
        println(button)
    }
    
    func betMaxButtonPressed(button:UIButton)
    {
        println(button)
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
    }
}

