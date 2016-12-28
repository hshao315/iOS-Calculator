//
//  ViewController.swift
//  Calculator
//
//  Created by Hui Shao on 12/28/16.
//  Copyright © 2016 Hui Shao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // the label to display result
    @IBOutlet weak var display: UILabel!
    
    // whether to clear display
    var shouldClearDisplay = true
    
    
    // the action for digit
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!

        if shouldClearDisplay {
            display.text = digit
        } else {
            let textDisplayed = display.text!
            display.text = textDisplayed + digit
        }

        // once user inputs a digit, no need to clear display
        shouldClearDisplay = false
        
    }

    // the action for operations
    @IBAction func performOperation(_ sender: UIButton) {

        if let operation = sender.currentTitle {
            if operation == "π" {
                display.text = String(M_PI)
            }
        }
        
        // don't allow to input more after the operation
        shouldClearDisplay = true
    }
}

