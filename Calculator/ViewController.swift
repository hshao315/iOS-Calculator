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
    @IBOutlet private weak var display: UILabel!
    
    // whether to clear display
    private var shouldClearDisplay = true
    
    private var displayValue : Double {
        // get a double from display
        get {
            return Double(display.text!)!
        }
        // set the display text to new value by =
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    // the action for digit
    @IBAction private func touchDigit(_ sender: UIButton) {
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
    @IBAction private func performOperation(_ sender: UIButton) {

        // set the value to calculate
        if !shouldClearDisplay {
            brain.setOperand(operand: displayValue)
            // don't allow to input more after the operation
            shouldClearDisplay = true
        }
        
        // do the calculation and update result
        if let operation = sender.currentTitle {
            brain.performOperation(symbol: operation)
        }

        // show the result on display
        displayValue = brain.result
    }
}

