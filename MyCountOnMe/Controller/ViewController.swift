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
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
    }
    
    // MARK: - Functions for the actions
    private func handleNumber(number: Int) {
        updateText(with: number)
    }
    private func handleOperation(tag: Int) {
        switch tag {
        case 0: updateText(with: .plus)
        case 1: updateText(with: .minus)
        case 2: updateText(with: .divide)
        case 3: updateText(with: .multiply)
        case 4:
            updateText(with: .equal)
        default: break
        }
        calcul.startCalculationProcess()
        if calcul.result != nil {
            if !calcul.isResultADouble {
                updateText(with: Int(calcul.result!))
            }
            else { updateText(with: calcul.result!.round(to: 2))}
        }
    }
    
    private func handleReset() {
        calcul.equation.removeAll()
        calcul.elements.removeAll()
        calcul.savedEquation.removeAll()
        calcul.result = nil
        textView.text = calcul.equation
    }
    
    // MARK: - User Interface
    // The following functions update the text view with the right number, or character.
    private func updateText(with int: Int) {
        calcul.equation.append("\(int)")
        calcul.savedEquation.append("\(int)")
        textView.text = calcul.equation
    }
    private func updateText(with double: Double) {
        calcul.equation.append("\(double)")
        calcul.savedEquation.append("\(double)")
        textView.text = calcul.equation
    }
    private func updateText(with operation : OperatorType) {
        calcul.equation.append(" \(operation.rawValue) ")
        calcul.savedEquation.append(" \(operation.rawValue) ")
        textView.text = calcul.equation
    }
}

