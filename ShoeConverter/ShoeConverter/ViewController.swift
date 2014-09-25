//
//  ViewController.swift
//  ShoeConverter
//
//  Created by Tim on 9/24/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet var mensShoeSizeTextField: UITextField!
    @IBOutlet var mensConvertedShoeSizeLabel: UILabel!
    @IBAction func mensConvertButtonPressed(sender: UIButton) {
        let conversionConstant = 30
        mensConvertedShoeSizeLabel.hidden = false
        mensConvertedShoeSizeLabel.text = "\(mensShoeSizeTextField.text.toInt()! + conversionConstant) in European shoe size"
    }

    
    @IBOutlet var womensShoeSizeTextField: UITextField!
    @IBOutlet var womensShoeSizeLabel: UILabel!
    @IBAction func womensConvertButtonPressed(sender: UIButton) {
        let conversionConstant = 30.5
        womensShoeSizeLabel.hidden = false
        let sizeFromTextField = Double((womensShoeSizeTextField.text as NSString).doubleValue)
        womensShoeSizeLabel.text = "\(sizeFromTextField + conversionConstant) in European shoe size"
    }
}

