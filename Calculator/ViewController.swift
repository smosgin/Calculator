//
//  ViewController.swift
//  Calculator
//
//  Created by Seth Mosgin on 5/8/17.
//  Copyright © 2017 Seth Mosgin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    var isFloatingPoint = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        //Demonstrates how to call a function.
        drawHorizontalLine(from: 5.0, to: 8.5, using: UIColor.blue)
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let textCurrentlyInDisplay = display.text!
            if digit == "." && textCurrentlyInDisplay.range(of: ".") != nil {
                return;
            }
            display.text = textCurrentlyInDisplay + digit
            print("\(digit) was touched")
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
    
    
    
    
    
    
    
    //Demonstrates a function. It has internal (startX) variables for use inside the function, and external (from) variables for use outside of the function
    func drawHorizontalLine(from startX: Double, to endX: Double, using color: UIColor) {
        
    }
    	

}

