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
        updateText(with: sender.tag)
    }
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        handleOperation(tag: sender.tag)
    }
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        handleReset()
    }
    
    // MARK: - Properties
    let calcul = Calcul()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
    }
    
    // MARK: - Methods for the actions
    private func handleOperation(tag: Int) {
        // We check first if we can add an operator
        if calcul.canAddOperator {
            // We check if we can add an operator ( the last element of the equation should be a number
            if !calcul.isFinished {
                // We check if the calculation is finished
                // Following the tag of the button, we update the text view with the according operator
                // Then we start the calculation process
                switch tag {
                case 0: updateText(with: .plus)
                case 1: updateText(with: .minus)
                case 2: updateText(with: .divide)
                case 3: updateText(with: .multiply)
                case 4: updateText(with: .equal)
                default: break
                }
                calcul.startCalculationProcess()
                guard let result = calcul.result else {
                    // There isn't a result
                    if calcul.lastOperatorType == .equal {
                        // The last operator is equal but the result is nil
                        // It means the calculation was a division by 0
                        showSystemAlert(message: "You can't divide by 0 !")
                    }
                    return
                }
                if calcul.isResultADouble {
                    // The result is a double
                    // We display the result with two digits
                    updateText(with: result.round(to: 2))
                } else {
                    // The result is not a double
                    // We display an integer
                    updateText(with: Int(result))
                }
            } else {
                // The calculation is finished
                showSystemAlert(message: "Please start a new calcul")}
        } else {
            // We can't add an operator
            showSystemAlert(message: "Please enter a number !")
        }
    }
    private func handleReset() {
        calcul.equation.removeAll()
        calcul.result = nil
        textView.text = ""
    }
    
    // MARK: - User Interface
    // The following functions update the text view with the right number, or operator.
    private func updateText(with int: Int) {
        calcul.equation.append("\(int)")
        textView.text.append("\(int)")
    }
    private func updateText(with double: Double) {
        calcul.equation.append("\(double)")
        textView.text.append("\(double)")
    }
    private func updateText(with operation : OperatorType) {
        calcul.equation.append(" \(operation.rawValue) ")
        textView.text.append(" \(operation.rawValue) ")
    }
}
