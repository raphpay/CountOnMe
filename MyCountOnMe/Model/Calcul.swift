//
//  Calcul.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 01/11/2020.
//

//Pas de UIKit
import Foundation

enum Operation: String {
    case add = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "÷"
    case equal = "="
}

class Calcul {
    var elements = String()
    var firstElement : Double = 0
    var operationElement : Operation = .add
    var secondElement : Double = 0
    var result : Double?
    
    var canAddOperator : Bool {
        return elements.last != " " && elements != ""
    }
    var isFinished: Bool {
        return result != nil
    }
    
    func calculate(completion: ((Bool) -> Void)? = nil) {
        let stringArray = elements.components(separatedBy: " ")
        if let firstNumber = Double(stringArray[0]),
           let secondNumber = Double(stringArray[2]),
           let operation = Operation(rawValue: stringArray[1]) {
            switch operation {
            case .add : add(number1: firstNumber, with: secondNumber)
            case .minus : substract(number1: firstNumber, with: secondNumber)
            case .multiply : multiply(number1: firstNumber, with: secondNumber)
            case .divide : divide(number1: firstNumber, with: secondNumber)
            default: break
            }
            if let result = result {
                elements.append(" \(result)")
            } else {
                elements.append("Error !")
            }
        }
    }
    
    private func add(number1 : Double, with number2: Double) {
        result = number1 + number2
    }
    private func substract(number1 : Double, with number2: Double) {
        result = number1 - number2
    }
    private func multiply(number1 : Double, with number2: Double) {
        result = number1 * number2
    }
    
    private func divide(number1 : Double, with number2: Double) {
        if number2 != 0 {
            result = number1 / number2
        } else { result = nil }
    }
}
