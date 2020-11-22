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
    var equation = String()
    var result: Double?
    private var savedIndex: Int = 0
    var isResultADouble: Bool {
        guard result != nil else { return false  }
        return floor(result!) != result!
    }
    private var elements: [String] {
        return equation.split(separator: " ").map { "\($0)"}
    }
    private var isEnoughElements: Bool {
        return elements.count >= 3
    }
    private var lastOperatorType : OperatorType? {
        guard let lastElement = elements.last,
              let operatorType = convertIntoOperator(lastElement) else { return nil }
        return operatorType
    }
    private var isEquationReduced: Bool {
        if lastOperatorType == .equal && elements.count <= 4 {
            return true
        }
        return false
    }
    private var lastOperatorHasPriority: Bool {
        if lastOperatorType == .equal {
            let element = elements[elements.count - 3]
            guard let newOperatorType = convertIntoOperator(element) else { return false }
            if newOperatorType == .multiply || newOperatorType == .divide {
                return true
            }
        } else {
            if lastOperatorType == .multiply || lastOperatorType == .divide {
                return true
            }
        }
        return false
    }
    private var canCalculate = false
    
    
    func startCalculationProcess() {
        if isEnoughElements {
            if isEquationReduced {
                calculate(at: 0)
            } else {
                if lastOperatorHasPriority {
                    if canCalculate {
                        calculate(at: savedIndex)
                        canCalculate = false
                        if isEquationReduced {
                            calculate(at: 0)
                        } else {
                            if lastOperatorHasPriority {
                                savedIndex = elements.count - 2
                                canCalculate = true
                            }
                            canCalculate = true
                        }
                    } else {
                        savedIndex = elements.count - 2
                        canCalculate = true
                    }
                } else {
                    calculate(at: 0)
                }
            }
        }
    }
    
    private func calculate(at index : Int) {
        guard let firstOperand = Double(elements[index]),
              let operatorType = convertIntoOperator(elements[index + 1]),
              let secondOperand = Double(elements[index + 2]) else { return }
        var currentResult: Double?
        switch operatorType {
        case .plus      : currentResult = add(number1: firstOperand, with: secondOperand)
        case .minus     : currentResult = substract(number1: firstOperand, with: secondOperand)
        case .divide    : currentResult = divide(number1: firstOperand, with: secondOperand)
        case .multiply  : currentResult = multiply(number1: firstOperand, with: secondOperand)
        default:
            break
        }
        guard let unwrappedResult = currentResult else { return }
        if isEquationReduced {
            result = unwrappedResult
            canCalculate = false
        } else {
            createNewEquation(with: unwrappedResult, at: index)
        }
    }
    
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
    
    private func createNewEquation(with currentResult: Double, at index: Int) {
        var saved = elements
        saved.remove(at: index)
        saved.remove(at: index)
        saved.remove(at: index)
        saved.insert(String(currentResult), at: index)
        equation = saved.joined(separator: " ")
        equation.append(" ")
    }
    
    private func convertIntoOperator(_ string: String) -> OperatorType? {
        var operatorType: OperatorType?
        switch string {
        case "+": operatorType = .plus
        case "-": operatorType = .minus
        case "÷": operatorType = .divide
        case "x": operatorType = .multiply
        case "=": operatorType = .equal
        default:
            break
        }
        return operatorType
    }
}
