//
//  ViewController.swift
//  Calculator
//
//  Created by Josh Jaslow on 12/6/16.
//  Copyright © 2016 Jaslow Enterprises. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    //MARK: - Variables
    //var numArr: [Double] = []
    //var funcArr: [Double] = []
    
    var calcValue1: Double = 0.0
    var calcValue2: Double = 0.0
    var trigNum: Double = 0.0
    var decimalPlace: Double = 0
    
    var algFunction: String = ""
    var trigFunction: String = ""
    
    var mathFunction: Bool = false
    var didTrig: Bool = false
    var isDecimaled: Bool = false
    var secondPressed: Bool = false
    
    //MARK: - Button Outlets
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var onOffButton: UILabel!
    @IBOutlet weak var readyToEqual: UIButton!
    @IBOutlet weak var ableToDecimal: UIButton!
    @IBOutlet weak var pie: UIButton!
    @IBOutlet weak var sine: UIButton!
    @IBOutlet weak var cosine: UIButton!
    @IBOutlet weak var tangent: UIButton!
    
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var AC: UIButton!
    @IBOutlet weak var equals: UIButton!
    @IBOutlet weak var second: UIButton!
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var subtract: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var divide: UIButton!
    
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        readyToEqual.isEnabled = false
        ableToDecimal.isEnabled = true
        changeNumButtonState(state: false)
        changeFuncButtonState(state: false)
        result.text = ""
        result.layer.masksToBounds = true
        result.layer.cornerRadius = 8.0
    }
    
    //MARK: - Function Buttons
    @IBAction func secondButton(_ sender: UIButton) {
        if secondPressed{
            sine.setTitle("SIN", for: .normal)
            cosine.setTitle("COS", for: .normal)
            tangent.setTitle("TAN", for: .normal)
            secondPressed = false
        }
        else{
            sine.setTitle("SIN-¹", for: .normal)
            cosine.setTitle("COS-¹", for: .normal)
            tangent.setTitle("TAN-¹", for: .normal)
            secondPressed = true
        }
    }
    
    @IBAction func onOffButton(_ sender: UISwitch) {
        if sender.isOn {
            onOffButton.text = "On"
            if calcValue1 > 0{
                result.text = String(calcValue1)
                changeFuncButtonState(state: true)
            }
            else{
                changeNumButtonState(state: true)
                changeFuncButtonState(state: true)
            }
        }
        else{
            onOffButton.text = "OFF"
            changeNumButtonState(state: false)
            changeFuncButtonState(state: false)
            result.text = ""
        }
    }
    
    @IBAction func addition(_ sender: UIButton) {
        if !mathFunction{
            result.text = "➕"
            algFunction = "Add"
            didTrig = false
            trigNum = 0
            mathFunction = true
            isDecimaled = false
            changeNumButtonState(state: true)
        }
        else{
            errorFunc()
        }
    }
    
    @IBAction func subtraction(_ sender: UIButton) {
        if !mathFunction{
            result.text = "➖"
            algFunction = "Subtract"
            didTrig = false
            trigNum = 0
            mathFunction = true
            isDecimaled = false
            changeNumButtonState(state: true)
        }
        
        else{
            errorFunc()
        }
    }
    
    @IBAction func multiplication(_ sender: UIButton) {
        if !mathFunction{
            result.text = "✖️"
            algFunction = "Multiply"
            didTrig = false
            trigNum = 0
            mathFunction = true
            isDecimaled = false
            changeNumButtonState(state: true)
        }
        
        else{
            errorFunc()
        }
    }
    
    @IBAction func division(_ sender: UIButton) {
        if !mathFunction{
            result.text = "➗"
            algFunction = "Divide"
            didTrig = false
            trigNum = 0
            mathFunction = true
            isDecimaled = false
            changeNumButtonState(state: true)
        }
        else{
            errorFunc()
        }
    }

    @IBAction func tangent(_ sender: UIButton) {
        if !didTrig{
            result.text = "TAN("
            tangent.setTitle(")", for: .normal)
            didTrig = true
            trigFunction = "tan"
        }
        else if didTrig && (tangent.titleLabel!.text == ")"){
            tangent.setTitle("TAN", for: .normal)
            result.text = String(trig())
            changeNumButtonState(state: false)
        }
        else {
            errorFunc()
        }
    }
    
    @IBAction func cosine(_ sender: UIButton) {
        if !didTrig{
            result.text = "COS("
            cosine.setTitle(")", for: .normal)
            didTrig = true
            trigFunction = "cos"
        }
        else if didTrig && (cosine.titleLabel!.text == ")"){
            cosine.setTitle("COS", for: .normal)
            result.text = String(trig())
            changeNumButtonState(state: false)
        }
        else {
            errorFunc()
        }
    }
    
    @IBAction func sine(_ sender: UIButton) {
        if !didTrig{
            result.text = "SIN("
            sine.setTitle(")", for: .normal)
            didTrig = true
            trigFunction = "sin"
        }
        else if didTrig && (sine.titleLabel!.text == ")"){
            sine.setTitle("SIN", for: .normal)
            result.text = String(trig())
            changeNumButtonState(state: false)
        }
        else {
            errorFunc()
        }
    }
    
    @IBAction func equals(_ sender: UIButton) {
        if mathFunction{
            let calcResult = (describing: calculate().roundTo(places: 3))
            result.text = String(calcResult)
            calcValue1 = calcResult
            calcValue2 = 0.0
            trigNum = 0
            algFunction = ""
            mathFunction = false
            readyToEqual.isEnabled = false
            isDecimaled = false
            changeNumButtonState(state: false)
        }
    }
    
    @IBAction func clearResults(_ sender: UIButton) {
        result.text = "0.0"
        calcValue1 = 0.0
        calcValue2 = 0.0
        trigNum = 0
        algFunction = ""
        trigFunction = ""
        mathFunction = false
        readyToEqual.isEnabled = false
        isDecimaled = false
        changeNumButtonState(state: true)
        
        sine.setTitle("SIN", for: .normal)
        cosine.setTitle("COS", for: .normal)
        tangent.setTitle("TAN", for: .normal)
    }
    
    @IBAction func clearView(_ sender: UIButton) {
        if !mathFunction {
            calcValue1 = 0.0
            result.text = String(calcValue1)
        }
        else {
            calcValue2 = 0.0
            result.text = String(calcValue2)
        }
        
        trigNum = 0
        sine.setTitle("SIN", for: .normal)
        cosine.setTitle("COS", for: .normal)
        tangent.setTitle("TAN", for: .normal)
    }
    
    //MARK: - Number Buttons
    @IBAction func pi(_ sender: UIButton) {
        if didTrig {
            if trigNum != 0 {
                trigNum = trigNum * Double.pi
            }
            else{
                trigNum = Double.pi
            }
            result.text = String(trigFunction + "( " + String(trigNum))
        }
        else if !mathFunction {
            calcValue1 = calcValue1 * Double.pi
            result.text = String(calcValue1)
        }
        else{
            calcValue2 = calcValue2 * Double.pi
            result.text = String(calcValue2)
        }
    }
    @IBAction func decimal(_ sender: UIButton) {
        isDecimaled = true
    }
    
    @IBAction func zero(_ sender: UIButton) {
        setCalcValues(num: 0)
    }
    
    @IBAction func one(_ sender: UIButton) {
        setCalcValues(num: 1)
    }
    
    @IBAction func two(_ sender: UIButton) {
        setCalcValues(num: 2)
    }
    
    @IBAction func three(_ sender: UIButton) {
        setCalcValues(num: 3)
    }
    
    @IBAction func four(_ sender: UIButton) {
        setCalcValues(num: 4)
    }
    
    @IBAction func five(_ sender: UIButton) {
        setCalcValues(num: 5)
    }
    
    @IBAction func six(_ sender: UIButton) {
        setCalcValues(num: 6)
    }
    
    @IBAction func seven(_ sender: UIButton) {
        setCalcValues(num: 7)
    }
    
    @IBAction func eight(_ sender: UIButton) {
        setCalcValues(num: 8)
    }
    
    @IBAction func nine(_ sender: UIButton) {
        setCalcValues(num: 9)
    }
    
    //MARK: - Methods
    func setCalcValues(num: Double){
        if didTrig {
            if isDecimaled{
                decimalPlace += 1
                trigNum += num * (pow(10,-decimalPlace))
                result.text = String(trigFunction + "( " + String(trigNum))
                ableToDecimal.isEnabled = false
            }
            else{
                trigNum = (trigNum * 10) + num
                result.text = String(trigFunction + "( " + String(trigNum))
            }
            
            if !mathFunction {
                readyToEqual.isEnabled = false
            }
            else {
                readyToEqual.isEnabled = true
            }
        }
        else if !mathFunction {
            if isDecimaled{
                decimalPlace += 1
                calcValue1 += num * (pow(10,-decimalPlace))
                result.text = String(calcValue1)
                ableToDecimal.isEnabled = false
            }
            else{
                calcValue1 = (calcValue1 * 10) + num
                result.text = String(calcValue1)
            }
            readyToEqual.isEnabled = false
        }
        else{
            if isDecimaled{
                decimalPlace += 1
                calcValue2 += num * (pow(10,-decimalPlace))
                result.text = String(calcValue2)
                ableToDecimal.isEnabled = false
            }
            else{
                calcValue2 = (calcValue2 * 10) + num
                result.text = String(calcValue2)
            }
            readyToEqual.isEnabled = true
        }
    }
    
    func errorFunc() {
        result.text = "ERROR"
        calcValue1 = 0.0
        calcValue2 = 0.0
        trigNum = 0
        algFunction = ""
        mathFunction = false
        readyToEqual.isEnabled = false
        isDecimaled = false
        changeNumButtonState(state: true)
        
        sine.setTitle("SIN", for: .normal)
        cosine.setTitle("COS", for: .normal)
        tangent.setTitle("TAN", for: .normal)
    }
    
    func calculate() -> Double {
        let double1 = calcValue1
        let double2 = calcValue2
        switch algFunction {
        case "Add":
            return (double1 + double2)
        case "Subtract":
            return (double1 - double2)
        case "Multiply":
            return (double1 * double2)
        case "Divide":
            return (double1 / double2)
        default:
            return 0
        }
    }
    
    func trig() -> Double {
        let doubleTrig = ((trigNum * Double.pi) / 180)
        switch trigFunction {
        case "sin":
            return sin(doubleTrig)
        case "cos":
            return cos(doubleTrig)
        case "tan":
            return tan(doubleTrig)
        case "arcSin":
            return 0
        case "arcCos":
            return 0
        case "arcTan":
            return 0
        default:
            return 0
        }
    }
    
    func changeNumButtonState(state: Bool) {
        zero.isEnabled = state
        one.isEnabled = state
        two.isEnabled = state
        three.isEnabled = state
        four.isEnabled = state
        five.isEnabled = state
        six.isEnabled = state
        seven.isEnabled = state
        eight.isEnabled = state
        nine.isEnabled = state
        ableToDecimal.isEnabled = state
        decimalPlace = 0
        didTrig = !state
    }
    
    func changeFuncButtonState(state: Bool){
        AC.isEnabled = state
        C.isEnabled = state
        equals.isEnabled = state
        pie.isEnabled = state
        sine.isEnabled = state
        cosine.isEnabled = state
        tangent.isEnabled = state
        add.isEnabled = state
        subtract.isEnabled = state
        multiply.isEnabled = state
        divide.isEnabled = state
        second.isEnabled = state
    }
}

extension Double {
    // Checks if double has a decimal or not
    var isInteger: Bool {return rint(self) == self}
    // Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

