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
        switch textView.text.last {
        case "+": print("plus")
        case "-": print("minus")
        case "x": print("mult")
        case "÷": print("div")
        default:break
        }
        
        updateText(with: number)
    }
    
    func handleOperation(tag: Int) {
        switch tag {
        case 0: updateText(with: .add)
        case 1: updateText(with: .minus)
        case 2: updateText(with: .divide)
        case 3: updateText(with: .multiply)
        case 4:
            //TODO: Create a string array
            updateText(with: .equal)
            calcul.equal()
        default:
            break
        }
    }
    
    func handleReset() {
        textView.text = ""
        calcul.elements.removeAll()
    }
    
    private func updateText(with number: Int) {
        let stringNumber = String(number)
        calcul.elements.append("\(stringNumber)")
        DispatchQueue.main.async {
            self.textView.text = self.calcul.elements
        }
        print(calcul.elements)
    }
    
    private func updateText(with operation : Operation) {
        if calcul.canAddOperator {
            calcul.elements.append(" \(operation.rawValue) ")
            DispatchQueue.main.async {
                self.textView.text = self.calcul.elements
            }
        } else {
            //TODO: Show alert message
            print("huho")
        }
        print(calcul.elements)
    }
    
}

