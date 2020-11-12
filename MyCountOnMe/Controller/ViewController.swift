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
        updateText(with: number)
    }
    private func handleOperation(tag: Int) {
        // When clicking an operator, the text view updates with the correct one.
        switch tag {
        case 0: updateText(with: .add)
        case 1: updateText(with: .minus)
        case 2: updateText(with: .divide)
        case 3: updateText(with: .multiply)
        case 4: handleEqualTap()
            
        default:
            break
        }
    }
    private func handleEqualTap() {
        // This function is called when the user tap "=" on the screen.
        // It update the text, and handle the resolution of the equation tapped by the user, if one exists.
        // It also show the result of the equation, if this one exists.
        // Display the result accordingly as a double or as an integer.
        updateText(with: .equal)
        calcul.calculate(operation: calcul.equation)
        guard let result = calcul.result else {
            showSystemAlert(message: "You can't divide by 0")
            return
        }
        if calcul.resultIsADouble {
            updateText(with: result)
        } else {
            updateText(with: Int(result))
        }
    }
    private func handleReset() {
        // Reset the text view, the calcul equation and result.
        textView.text = ""
        calcul.equation.removeAll()
        calcul.result = nil
    }
    
    // MARK: - User Interface
    // The following functions update the text view with the right number, or character.
    private func updateText(with int: Int) {
        let stringNumber = String(int)
        calcul.equation.append("\(stringNumber)")
        DispatchQueue.main.async {
            self.textView.text = self.calcul.equation
        }
    }
    private func updateText(with double: Double) {
        let stringNumber = String(double)
        calcul.equation.append("\(stringNumber)")
        DispatchQueue.main.async {
            self.textView.text = self.calcul.equation
        }
    }
    private func updateText(with operation : Operation) {
        if calcul.canAddOperator {
            calcul.equation.append(" \(operation.rawValue) ")
            DispatchQueue.main.async {
                self.textView.text = self.calcul.equation
            }
        } else {
            showSystemAlert(message: "Please enter a number, not an operator")
        }
    }
    
}

