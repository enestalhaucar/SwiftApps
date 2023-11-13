//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Enes Talha Uçar  on 13.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // firstNumber, secondNumber, operator, haveResult, numAfterResult, resultNumber
    
    var firstNumber : String = ""
    var secondNumber : String = ""
    var operation : String = ""
    var resultNumber : String = ""
    var haveResult : Bool = false
    var numAfterResult : String = ""
    
    // Operations
    
    @IBAction func add(_ sender: Any) {
        operation = "+"
    }
    @IBAction func substract(_ sender: Any) {
        operation = "-"
    }
    @IBAction func multiply(_ sender: Any) {
        operation = "x"
    }
    
    @IBAction func divide(_ sender: Any) {
        operation = "/"
    }
    @IBAction func percentage(_ sender: Any) {
        operation = "%"
    }
    
    @IBAction func equals(_ sender: Any) {
        equalAction()
    }
    
    @IBOutlet weak var equalBtn: UIButton!
    func equalAction() {
        resultNumber = String(doOperation())
        let numArr = resultNumber.components(separatedBy: ".")
        if numArr[1] == "0"{
            numOnScreen.text = numArr[0]
        }else {
            numOnScreen.text = resultNumber
        }
        numAfterResult = ""
    }
    
    @IBOutlet weak var numOnScreen: UILabel!
    
    
    
    @IBOutlet var calcButton: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }

    @IBAction func numPressed(_ sender: UIButton) {
        if operation == "" {
            firstNumber += String(sender.tag)
            numOnScreen.text = firstNumber
        } else if operation != "" && !haveResult {
            secondNumber += String(sender.tag)
            numOnScreen.text = secondNumber
        } else if operation != "" && haveResult {
            numAfterResult += String(sender.tag)
            numOnScreen.text = numAfterResult
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstNumber = ""
        secondNumber = ""
        operation = ""
        resultNumber = ""
        haveResult = false
        numAfterResult = ""
        
        numOnScreen.text = "0"
    }
    
    func doOperation() -> Double {
        if operation == "+" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! + Double(secondNumber)!
            } else {
                return Double(resultNumber)! + Double(numAfterResult)!
            }
        } 
        else if operation == "-" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! - Double(secondNumber)!
            } else {
                return Double(resultNumber)! - Double(numAfterResult)!
            }
        }
        else if operation == "x" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! * Double(secondNumber)!
            } else {
                return Double(resultNumber)! * Double(numAfterResult)!
            }
        }
        else if operation == "/" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! / Double(secondNumber)!
            } else {
                return Double(resultNumber)! /   Double(numAfterResult)!
            }
        }
        else if operation == "%" {
            if !haveResult {
                haveResult = true
                return Double(firstNumber)! / 100
            } else {
                return Double(resultNumber)! / 100
            }
        }
        return 0
    }
}

