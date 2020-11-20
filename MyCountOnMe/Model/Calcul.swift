//
//  Calcul.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 01/11/2020.
//

//Pas de UIKit
import Foundation

// An enumeration with the existing operators.
enum OperatorType: String {
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "÷"
    case equal = "="
}

class Calcul {
    // MARK: - Non Private
    var equation = String()
    var calculatedEquation = String()
    var result: Double?
    var lastOperatorType: OperatorType = .plus
    
    var isFinished : Bool {
        result != nil
    }
    var canAddOperator: Bool {
        true
    }
    var resultIsADouble: Bool {
        guard result != nil else { return false }
        return floor(result!) != result
    }
    var canReduceOperation : Bool {
        return elements.count > 3 &&
            lastOperatorType == .plus || lastOperatorType == .minus
            || lastOperatorType != .multiply || lastOperatorType == .divide
    }
    var isFirstReduction: Bool = true
    var isASpecialOperator: Bool {
        lastOperatorType == OperatorType.multiply || lastOperatorType == OperatorType.divide
    }
    var elements = [String]()
    
    // MARK: - Private
    
    
    
    // MARK: - Non Private
    
    func createArray(from string: String) {
        print("createStringArray")
        print(string)
        elements = string.components(separatedBy: " ")
        print("elements : \(elements)")
    }
    
    func calculate() {
        print("calculate")
        if isFirstReduction {
            print("isFirstReduction")
            createArray(from: equation)
        } else {
            print("!isFirstReduction")
            print("currentEquation !isFirstReduction \(calculatedEquation)")
            createArray(from: calculatedEquation)
        }
        
        if canReduceOperation {
            print("canReduceOperation")
            reduceOperation()
        } else {
            // Je suis dans le cas du x ou du ÷
            // Attendre le calcul
            print(calculatedEquation)
        }
    }
    
    func expression() {
        print(equation)
        let mathExpression = NSExpression(format: equation)
        print("mathExpression \(mathExpression)")
        if let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double {
            print(mathValue)
        }
    }
    
    func calculatePrioritizedOperator(at index: Int) {
        print("calculatePrioritizedOperator")
        createArray(from: calculatedEquation)
        guard let firstOperand = Double(elements[index - 1]),
              let secondOperand = Double(elements[index + 1]) else { print("return");return }
        let currentOperatorType = convertOperator(from: elements[index])
        print(firstOperand)
        print(secondOperand)
        print(currentOperatorType)
        var currentResult: Double?
        
        switch currentOperatorType {
        case .multiply: currentResult = multiply(number1: firstOperand, with: secondOperand)
        case .divide: currentResult = divide(number1: firstOperand, with: secondOperand)
        default: break
        }
        
        guard currentResult != nil else { return }
        print("ok")
        createCurrentEquation(with: currentResult!, at: index - 1)
    }
    
    func finish(_ equation : String) {
        print("finishEquation")
        createArray(from: equation)
        print("finishEquation \(elements)")
        guard let firstOperand = Double(elements[0]),
              let secondOperand = Double(elements[2]) else { return }
        let currentOperatorType = convertOperator(from: elements[1])
        print(firstOperand)
        print(secondOperand)
        print(currentOperatorType)
        switch currentOperatorType {
        case .plus: result = add(number1: firstOperand, with: secondOperand)
        case .minus: result = substract(number1: firstOperand, with: secondOperand)
        case .multiply: result = multiply(number1: firstOperand, with: secondOperand)
        case .divide: result = divide(number1: firstOperand, with: secondOperand)
        default: break
        }
        print(result)
    }
    
    // MARK: - Private
    private func add(number1: Double, with number2: Double) -> Double {
        return number1 + number2
    }
    private func substract(number1: Double, with number2: Double) -> Double {
        return number1 - number2
    }
    private func multiply(number1: Double, with number2: Double) -> Double {
        return number1 * number2
    }
    private func divide(number1: Double, with number2: Double) -> Double? {
        guard number2 != 0 else { return nil }
        return number1 / number2
    }
    
    
    private func reduceOperation() {
        print("reduceOperation")
        guard let firstOperand = Double(elements[0]),
              let secondOperand = Double(elements[2]) else { return }
        let currentOperatorType = convertOperator(from: elements[1])
        var currentResult : Double?
        print(firstOperand)
        print(currentOperatorType)
        print(secondOperand)
        switch currentOperatorType {
        case .plus: currentResult = add(number1: firstOperand, with: secondOperand)
        case .minus: currentResult = substract(number1: firstOperand, with: secondOperand)
        case .multiply: currentResult = multiply(number1: firstOperand, with: secondOperand)
        case .divide: currentResult = divide(number1: firstOperand, with: secondOperand)
        default: break
        }
        print("= \(currentResult)")
        guard currentResult != nil else { return }
        createCurrentEquation(with: currentResult!)
        isFirstReduction = false
    }
    
    private func convertOperator(from string : String) -> OperatorType {
        var operatorType = OperatorType.minus
        switch string {
        case "+": operatorType = .plus
        case "-": operatorType = .minus
        case "x": operatorType = .multiply
        case "÷": operatorType = .divide
        default: break
        }
        return operatorType
    }
    private func createCurrentEquation(with currentResult: Double, at index: Int = 0) {
        print("createCurrentEquation")
        elements.remove(at: index)
        elements.remove(at: index)
        elements.remove(at: index)
        print("elements 1 :  \(elements)")
        elements.insert(String(currentResult), at: index)
        calculatedEquation = elements.joined(separator: " ")
        print(calculatedEquation)
        print("elements 2 : \(elements)")
    }
    
}
