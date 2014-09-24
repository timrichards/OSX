//
//  ViewController.swift
//  ShoeConverter
//
//  Created by Tim on 9/24/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mensShoeSizeTextField: UITextField!
    @IBOutlet var mensConvertedShoeSizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func convertButtonPressed(sender: UIButton) {
        let sizeFromTextField = mensShoeSizeTextField.text
        let numberFromTextField = sizeFromTextField.toInt()
        var integerFromTextField = numberFromTextField!
        let conversionConstant = 30
        integerFromTextField += conversionConstant
        mensConvertedShoeSizeLabel.hidden = false
        mensConvertedShoeSizeLabel.text = "\(integerFromTextField)"
        
    }

}

