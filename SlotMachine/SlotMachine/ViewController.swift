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
    
    private func createViews()
    {
        let heights:[CGFloat] = [1, 3, 1, 1]
        let colors:[UIColor] = [UIColor.redColor(), UIColor.blackColor(), UIColor.lightGrayColor(), UIColor.blackColor()]

        let kMarginForView:CGFloat = 10
        var yOffset:CGFloat = 0
        
        for (i, view) in enumerate(views)
        {
            view.frame.origin.x = self.view.bounds.origin.x + kMarginForView
            view.frame.size.width = self.view.bounds.width - (2*kMarginForView)
            
            let height = self.view.bounds.height/6 * heights[i]
            view.frame.size.height = height
            
            //Vertical positioning is offset
            view.frame.origin.y = yOffset
            yOffset += height
            
            view.backgroundColor = colors[i]
            self.view.addSubview(view)
        }
        
        // First view.
        self.titleLabel.text = "Super Slots"                                // A        mutable let object
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = views[0].center
        views[0].addSubview(self.titleLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
