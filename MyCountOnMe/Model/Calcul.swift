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
    case multiply = "x"
    case divide = "÷"
    case equal = "="
}

class Calcul {
    // MARK: - Properties
    var equation            = String()
    var savedEquation       = String()
    var result              : Double? = nil
    var elements            = [String]()
    
    // MARK: - Private Properties
    private var savedEquationHasChanged     = false
    private var isCalculationSuspended      = false
    private var savedIndex                  = Int()
    
    // MARK: - Computed Properties
    var isResultADouble: Bool {
        guard result != nil else { return false }
        return floor(result!) != result
    }
    
    var isCalculationPossible: Bool {
        return elements.count >= 3
    }
    
    var lastOperatorType: OperatorType? {
        guard let lastIndex = lastOperatorIndex,
            let operatorType = convertIntoOperatorType(elements[lastIndex]) else { return nil }
        return operatorType
    }

    var isLastOperatorHasPriority: Bool {
        if lastOperatorType == .multiply || lastOperatorType == .divide {
            return true
        }
        return false
    }
    
    var lastOperatorIndex: Int? {
        guard elements.count > 2 else { return nil }
        return elements.count - 2
    }
    
    var isEquationReduced: Bool {
        return elements.count <= 5 && lastOperatorType == .equal
    }
    
    var isEquationFinished: Bool {
        return elements.count <= 3 && lastOperatorType == .equal
    }
    
    // MARK: - Open Methods
    func startCalculationProcess() {
        updateEquationArray(with: equation)
        if isCalculationSuspended {
            calculate(at: savedIndex)
            isCalculationSuspended = false
        }
        else {
            if !isEquationReduced {
                reduceOperation() }
        }
        if isEquationReduced {
            if !isEquationFinished {
                finishCalcul()
            } else {
                result = Double(elements[0])!
            }
        } else {
            reduceOperation()
        }
    }
    
    // MARK: - Mathematical Methods
    private func add(number1 : Double, number2: Double) -> Double {
        return number1 + number2
    }
    
    private func substract(number1: Double, number2: Double) -> Double {
        return number1 - number2
    }
    
    private func multiply(number1: Double, number2: Double) -> Double {
        return number1 * number2
    }
    
    private func divide(number1: Double, number2: Double) -> Double? {
        guard number2 != 0 else { return nil }
        return number1 / number2
    }
    
    // MARK: - Private Methods
    private func reduceOperation() {
        if isCalculationPossible {
            if isLastOperatorHasPriority {
                guard let lastIndex = lastOperatorIndex else { return }
                savedIndex = lastIndex
                isCalculationSuspended = true
            } else {
                if isEquationReduced {
                    finishCalcul()
                } else {
                    calculate(at: 1)
                }
            }
        }
    }
    
    private func calculate(at index: Int) {
        updateEquationArray(with: savedEquationHasChanged ? savedEquation : equation)
        guard let firstOperand = Double(elements[index - 1]),
              let lastOperator = convertIntoOperatorType(elements[index]),
              let secondOperand = Double(elements[index + 1]) else {return }
        var currentResult = Double()
        switch lastOperator {
        case .plus      : currentResult = add(number1: firstOperand, number2: secondOperand)
        case .minus     : currentResult = substract(number1: firstOperand, number2: secondOperand)
        case .multiply  : currentResult = multiply(number1: firstOperand, number2: secondOperand)
        case .divide    :
            guard secondOperand != 0 else { return }
            currentResult = divide(number1: firstOperand, number2: secondOperand)!
        default         : break
        }
        updateSavedEquation(with: currentResult, at: index)
    }
    
    private func finishCalcul() {
        updateEquationArray(with: savedEquationHasChanged ? savedEquation : equation)
        guard let firstOperand = Double(elements[0]),
              let operatorType = convertIntoOperatorType(elements[1]),
              let secondOperand = Double(elements[2]) else {  return }
        switch operatorType {
        case .plus      : result = add(number1: firstOperand, number2: secondOperand)
        case .minus     : result = substract(number1: firstOperand, number2: secondOperand)
        case .multiply  : result = multiply(number1: firstOperand, number2: secondOperand)
        case .divide    :
            guard secondOperand != 0 else { return }
            result = divide(number1: firstOperand, number2: secondOperand)!
        default: break
        }
    }
    
    private func updateEquationArray(with equation: String) {
        elements = savedEquation.components(separatedBy: " ")
    }
    
    private func convertIntoOperatorType(_ string: String) -> OperatorType? {
        var operatorType: OperatorType?
        switch string {
        case "+": operatorType = .plus
        case "-": operatorType = .minus
        case "x": operatorType = .multiply
        case "÷": operatorType = .divide
        case "=": operatorType = .equal
        default : break
        }
        return operatorType
    }
    
    private func updateSavedEquation(with currentResult: Double, at index: Int) {
        elements.remove(at: index - 1)
        elements.remove(at: index - 1)
        elements.remove(at: index - 1)
        elements.insert(String(currentResult), at: index - 1)
        savedEquation = elements.joined(separator: " ")
        savedEquationHasChanged = true
    }
}
