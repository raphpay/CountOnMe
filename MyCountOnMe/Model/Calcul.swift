//
//  Calcul.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 01/11/2020.
//

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
    //MARK: - Properties
    var equation = String()
    var result: Double?
    
    //MARK: - Computed Properties
    var isResultADouble: Bool {
        // To check if the result is a double or an integer, we 'floor' the result.
        // If the condition fails, then the result is a double.
        guard result != nil else { return false  }
        return floor(result!) != result!
    }
    var canAddOperator: Bool {
        // We take the last element of the equation
        // If we can't convert it into an operator, then we can't add an operator to the equation
        guard let lastElement = elements.last,
            convertIntoOperator(lastElement) == nil else { return false }
        return true
    }
    var isFinished: Bool {
        // If there is a result, the calculation is finished
        return result != nil
    }
    var lastOperatorType : OperatorType? {
        // We take the last element of the equation
        // If we can convert it into an operator, then this last operator is saved
        guard let lastElement = elements.last,
              let operatorType = convertIntoOperator(lastElement) else { return nil }
        return operatorType
    }
    
    //MARK: - Private Properties
    private var savedIndex: Int = 0
    private var canCalculate = false
    private var elements: [String] {
        // We split the equation with the spaces.
        // It creates an array of string elements
        return equation.split(separator: " ").map { "\($0)"}
    }
    private var isEnoughElements: Bool {
        // We check if there is enough elements to start the calculation
        return elements.count >= 3
    }
    private var isEquationReduced: Bool {
        // The equation is reduced when there is less than 4 elements, and the last operator is an equal
        // For example '3 + 3 =' is a reduced equation
        if lastOperatorType == .equal && elements.count <= 4 {
            return true
        }
        return false
    }
    private var lastOperatorHasPriority: Bool {
        // An operator that has priority is either multiply or divide
        // We check first if the last operator is an equal
        // If it's an equal, we take the last operator before this equal
        // We check then if it's a multiply or a divide operator.
        // If yes, he has the priority
        if lastOperatorType == .equal {
            let element = elements[elements.count - 3]
            if let newOperatorType = convertIntoOperator(element) {
                if newOperatorType == .multiply || newOperatorType == .divide { return true }
            }
        } else if lastOperatorType == .multiply || lastOperatorType == .divide { return true }
        return false
    }
    
    //MARK: - Methods
    func startCalculationProcess() {
        // This method has different levels of validation to calculate the equation.
        if isEnoughElements {
            //We check if there is enough elements to start the process
            if isEquationReduced {
                // If the equation is reduced, then there is only one operator.
                // We can then calculate
                calculate(at: 0)
            } else {
                // The equation is not reduced, it means there is at least two operators
                if lastOperatorHasPriority {
                    // If the last one has priority
                    if canCalculate {
                        // There is a number after the last operator
                        // We calculate at the saved index ( see line 107 and 115 )
                        calculate(at: savedIndex)
                        canCalculate = false
                        // The equation has been changed, we double-check before exiting the process
                        if isEquationReduced {
                            // The equation has only one operator
                            calculate(at: 0)
                        } else {
                            // The equation has two operators or more
                            if lastOperatorHasPriority {
                                // The last operator has priority
                                // There is no number after the operator, we wait for one.
                                savedIndex = elements.count - 2
                                canCalculate = true
                            }
                            canCalculate = true
                        }
                    } else {
                        // There is no number after the last operator,
                        // We wait for this number and save the index in order to calculate at the right place in the equation
                        savedIndex = elements.count - 2
                        canCalculate = true
                    }
                } else {
                    // The last operator doesn't have priority, we can calculate at the first element
                    calculate(at: 0)
                }
            }
        }
    }
    
    //MARK: - Calculation methods
    private func calculate(at index : Int) {
        // We check if there is at least two operands and one operator
        // Then following the operator type, we do the right math
        // If the equation is reduced, the current result is the final result
        // Else, we update the equation with the current result at the index of the first operand
        guard let firstOperand = Double(elements[index]),
              let operatorType = convertIntoOperator(elements[index + 1]),
              let secondOperand = Double(elements[index + 2]) else { return }
        var currentResult: Double?
        switch operatorType {
        case .plus      : currentResult = add(number1: firstOperand, with: secondOperand)
        case .minus     : currentResult = substract(number1: firstOperand, with: secondOperand)
        case .divide    : currentResult = divide(number1: firstOperand, with: secondOperand)
        case .multiply  : currentResult = multiply(number1: firstOperand, with: secondOperand)
        case .equal     : break
        }
        guard let unwrappedResult = currentResult else { return }
        if isEquationReduced {
            result = unwrappedResult
            canCalculate = false
        } else {
            createNewEquation(with: unwrappedResult, at: index)
        }
    }

    // The following four methods cover the math for the four possible operators
    // The divide operation can return a nil value if the second operand is 0
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
    
    //MARK: - Helper Methods
    private func createNewEquation(with currentResult: Double, at index: Int) {
        // We create a local copy of the elements,
        // We change the copy, removing the elements not necessary
        // We update with the current result at the index of the first operand
        // We convert the local copy to update the overall equation
        var saved = elements
        saved.remove(at: index)
        saved.remove(at: index)
        saved.remove(at: index)
        saved.insert(String(currentResult), at: index)
        equation = saved.joined(separator: " ")
        equation.append(" ")
    }
    
    private func convertIntoOperator(_ string: String) -> OperatorType? {
        // We convert a string into an operator
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
