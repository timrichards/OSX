//
//  ViewController.swift
//  Postcard
//
//  Created by Tim on 9/17/14.
//  Copyright (c) 2014 Tim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!   // ! is unwrapped optional
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var enterMessageTextView: UITextView!
    
    @IBOutlet weak var mailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendMailButtonPressed(sender: UIButton)
    {
        // Code will evaluate when user up-touches button
        messageLabel.hidden = false
        messageLabel.text = enterMessageTextView.text
        enterMessageTextView.text = ""
        enterNameTextField.resignFirstResponder()
        messageLabel.textColor = UIColor.redColor()
        mailButton.setTitle("Mail Sent", forState: UIControlState.Normal)
        
        nameLabel.hidden = false
        nameLabel.text = enterNameTextField.text
        nameLabel.textColor = UIColor.blueColor()
    }

}

