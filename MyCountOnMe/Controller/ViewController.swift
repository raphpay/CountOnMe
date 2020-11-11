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
    
    
    func handleNumber(number: Int) {
        updateText(with: number)
    }
    
    func handleOperation(tag: Int) {
        switch tag {
        case 0: updateText(with: .add)
        case 1: updateText(with: .minus)
        case 2: updateText(with: .divide)
        case 3: updateText(with: .multiply)
        case 4:
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
        default:
            break
        }
    }
    
    func handleReset() {
        textView.text = ""
        calcul.equation.removeAll()
        calcul.result = nil
    }
    
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

