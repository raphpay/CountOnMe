//
//  ViewController.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 01/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet var operatorButton: [UIButton]!
    
    // MARK: - Actions
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        handleNumber(number: sender.tag)
    }
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        handleOperation(tag: sender.tag)
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        handleReset()
    }
    
    // MARK: - Properties
    let calcul = Calcul()
    var result = Double(0)
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
    }
    
    // MARK: - Functions for the actions
    private func handleNumber(number: Int) {
        // When clicking a number, the text view updates with the correct one.
        guard !calcul.isFinished else {
            showSystemAlert(message: "Start a new calcul !")
            return
        }
        print(calcul.elements.count)
        updateText(with: number)
        if calcul.isASpecialOperator {
            calcul.calculatePrioritizedOperator(at: calcul.elements.count - 2)
        }
    }
    private func handleOperation(tag: Int) {
        // When clicking an operator, the text view updates with the correct one.
        switch tag {
        case 0 :
            updateText(with: .plus)
            calcul.calculate()
        case 1 :
            updateText(with: .minus)
            calcul.calculate()
        case 2 :
            updateText(with: .divide)
            calcul.calculate()
        case 3 :
            updateText(with: .multiply)
            calcul.calculate()
        case 4 :
            calcul.expression()
            updateText(with: .equal)
//            calcul.finish(calcul.calculatedEquation)
//            if calcul.resultIsADouble {
//                updateText(with: Double(calcul.result!))
//            } else {
//                updateText(with: Int(calcul.result!))
//            }
        
        default: break
        }
    }
    
    private func handleReset() {
        // Reset the text view, the calcul equation and result.
        textView.text = ""
        calcul.equation.removeAll()
        calcul.calculatedEquation.removeAll()
        calcul.result = nil
    }
    
    // MARK: - User Interface
    // The following functions update the text view with the right number, or character.
    private func updateText(with int: Int) {
        let stringNumber = String(int)
        calcul.equation.append("\(stringNumber)")
        calcul.calculatedEquation.append("\(stringNumber)")
        DispatchQueue.main.async {
            self.textView.text = self.calcul.equation
        }
    }
    private func updateText(with double: Double) {
        let stringNumber = String(double)
        calcul.equation.append("\(stringNumber)")
        calcul.calculatedEquation.append("\(stringNumber)")
        DispatchQueue.main.async {
            self.textView.text = self.calcul.equation
        }
    }
    private func updateText(with operation : OperatorType) {
        if calcul.canAddOperator {
            calcul.lastOperatorType = operation
            calcul.equation.append(" \(operation.rawValue) ")
            calcul.calculatedEquation.append(" \(operation.rawValue) ")
            DispatchQueue.main.async {
                self.textView.text = self.calcul.equation
            }
        } else {
            showSystemAlert(message: "Please enter a number, not an operator")
        }
    }
    
}

