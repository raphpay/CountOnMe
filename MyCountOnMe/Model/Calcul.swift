//
//  Calcul.swift
//  MyCountOnMe
//
//  Created by Raphaël Payet on 01/11/2020.
//

//Pas de UIKit
import Foundation

// An enumeration with the existing operators.
enum Operation: String {
    case add = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "÷"
    case equal = "="
}

class Calcul {
    //MARK: - Properties
    var equation = String()
    var firstElement : Double = 0
    var operationElement : Operation = .add
    var secondElement : Double = 0
    var result : Double?
    private var elementArray : [String] = []
    private var numberOfOperations: Int = 0
    private var numberOfSpecialOperations: Int = 0
    private var currentResult: Double?
    
    // MARK: - Computed properties
    var canAddOperator : Bool {
        return equation.last != " "
    }
    var isFinished: Bool {
        return result != nil
    }
    var resultIsADouble: Bool {
        guard result != nil else { return false }
        return floor(result!) != result
    }
    
    //MARK: - Main Method
    func calculate(operation : String) {
        // This function is th eonly one not private. It can be accessed anywhere on the project.
        // This function handle the calculation of an equation.
        // First, it create a string array of the equation. Each number is an element of the array.
        // Then it gets the number of special ( x and ÷ ), and non special ( + and - ) operations to be done.
        // It calculates the priority operations if there is, then the normal ones.
        // Finally the result is updated.
        createStringArray()
        numberOfOperations = getNumberOfOperations()
        numberOfSpecialOperations = getNumberOfSpecialOperations()
        while numberOfOperations != 0 {
            calculatePriorityOperators()
            calculateNormalOperators()
        }
        result = currentResult
    }
    
    private func calculatePriorityOperators() {
        // This function passes through all the prioritized equations and execute them.
        // We get the index of the special operation, then the two number that compose this part of the equation.
        // When the equation is done, we save the current result, and continue if another special operation is pending.
        while numberOfSpecialOperations != 0 {
            let index = getIndexOfSpecialOperation()
            guard let firstOperand = Double(elementArray[index - 1]),
                  let secondOperand = Double(elementArray[index + 1]) else { return }
            let currentOperation = getOperationType(from: elementArray[index])
            currentResult = makeOperation(number1: firstOperand, number2: secondOperand, operatorType: currentOperation)
            guard currentResult != nil else { numberOfSpecialOperations = 0; return }
            createNewEquation(with: currentResult!, at: index - 1)
            numberOfOperations = getNumberOfOperations()
            numberOfSpecialOperations = getNumberOfSpecialOperations()
        }
    }
    
    private func calculateNormalOperators() {
        // Same principe as the method below, except that this ones passes through the normal operations.
        while numberOfOperations != 0 {
            guard let firstOperand = Double(elementArray[0]),
                  let secondOperand = Double(elementArray[2]) else { return }
            let currentOperation = getOperationType(from: elementArray[1])
            currentResult = makeOperation(number1: firstOperand, number2: secondOperand, operatorType: currentOperation)
            guard currentResult != nil else { numberOfOperations = 0; return  }
            createNewEquation(with: currentResult!, at: 0)
            numberOfOperations = getNumberOfOperations()
        }
    }
    // MARK: - Calculation Methods
    // The following method return a number with the according calculation between two numbers.
    private func add(number1 : Double, with number2: Double) -> Double {
        return number1 + number2
    }
    private func substract(number1 : Double, with number2: Double) -> Double {
        return number1 - number2
    }
    private func multiply(number1 : Double, with number2: Double) -> Double{
        return number1 * number2
    }
    
    private func divide(number1 : Double, with number2: Double) -> Double? {
        guard number2 != 0 else { return nil }
        return number1 / number2
    }
    
    // MARK: - Helper Methods
    private func createStringArray(){
        // Create a string array from the string equation
        elementArray = equation.components(separatedBy: " ")
    }
    private func getNumberOfOperations() -> Int {
        // This method pass through the element of the equation and increment a variable that is returned.
        var numberOfOperations = 0
        for element in elementArray {
            if element == "+" || element == "-" || element == "x" || element == "÷" {
                numberOfOperations += 1
            }
        }
        return numberOfOperations
    }
    private func getNumberOfSpecialOperations() -> Int {
        // Same principe has the method below. Except this one focus on the special operators.
        var numberOfSpecialOperations = 0
        for element in elementArray {
            if element == "x" || element == "÷" {
                numberOfSpecialOperations += 1
            }
        }
        return numberOfSpecialOperations
    }
    private func getIndexOfSpecialOperation() -> Int {
        // Get and return the index of the special operation
        var index = 0
        for element in 0..<elementArray.count {
            if elementArray[element] == "x" || elementArray[element] == "÷" {
                index = element
            }
        }
        return index
    }
    private func getOperationType(from string: String) -> Operation {
        // Get operation type from a string character
        var operationType : Operation = .add
        switch string {
        case "+": operationType = .add
        case "-" : operationType = .minus
        case "x" : operationType = .multiply
        case "÷" : operationType = .divide
        default: break
        }
        return operationType
    }
    private func makeOperation(number1 : Double, number2: Double, operatorType: Operation) -> Double? {
        // This method do the right calculation according to the operator type
        var currentResult : Double?
        switch operatorType {
        case .add: currentResult = add(number1: number1, with: number2)
        case .minus: currentResult = substract(number1: number1, with: number2)
        case .multiply : currentResult = multiply(number1: number1, with: number2)
        case .divide : currentResult = divide(number1: number1, with: number2)
        default: break
        }
        return currentResult
    }
    private func createNewEquation(with currentResult : Double, at index : Int) {
        // Remove the first operand, the operator, and the second operand from the last calcul.
        // Then insert at the index of the last first operand, the new current result.
        // It creates then a new equation.
        guard !elementArray.isEmpty else { return }
        elementArray.remove(at: index)
        elementArray.remove(at: index)
        elementArray.remove(at: index)
        elementArray.insert(String(currentResult), at: index)
    }
}
