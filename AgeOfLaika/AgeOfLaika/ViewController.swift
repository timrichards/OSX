//
//  ViewController.swift
//  AgeOfLaika
//
//  Created by Tim on 9/25/14.
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


    @IBOutlet var dogYearsLabel: UITextView!
    @IBOutlet var peopleYearsTitleLabel: UILabel!
    @IBOutlet var peopleYearsDatumLabel: UILabel!
    @IBOutlet var mainTitleLabel: UILabel!
    @IBAction func ConvertDogYears(sender: UIButton) {
        peopleYearsTitleLabel.hidden = false;
        peopleYearsDatumLabel.hidden = false;
        let conversionConstant = 7.0
        let peopleYears = Double((dogYearsLabel.text! as NSString).doubleValue) * conversionConstant
        peopleYearsDatumLabel.text = "\(peopleYears)"
        mainTitleLabel.text! += "."
        mainTitleLabel.textColor = UIColor.blueColor()
    }
}

