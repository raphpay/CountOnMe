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
    var equation = String()
    var firstElement : Double = 0
    var operationElement : Operation = .add
    var secondElement : Double = 0
    var result : Double?
    private var elementArray : [String] = []
    
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
    
    func calculate(operation : String) {
        createStringArray()
        var numberOfOperations = getNumberOfOperations()
        var numberOfSpecialOperations = getNumberOfSpecialOperations()
        var currentResult : Double?
        while numberOfOperations != 0 {
            while numberOfSpecialOperations != 0 {
                let index = getIndexOfSpecialOperation()
                guard let firstOperand = Double(elementArray[index - 1]),
                      let secondOperand = Double(elementArray[index + 1]) else { return }
                let currentOperation = getOperationType(from: elementArray[index])
                currentResult = makeOperation(number1: firstOperand, number2: secondOperand, operatorType: currentOperation)
                guard currentResult != nil else { numberOfSpecialOperations = 0; return }
                createNewEquation(with: currentResult!, at: index - 1)
                numberOfSpecialOperations = getNumberOfSpecialOperations()
            }
            numberOfOperations = getNumberOfOperations()
            while numberOfOperations != 0 {
                guard let firstOperand = Double(elementArray[0]),
                      let secondOperand = Double(elementArray[2]) else { return }
                let currentOperation = getOperationType(from: elementArray[1])
                currentResult = makeOperation(number1: firstOperand, number2: secondOperand, operatorType: currentOperation)
                guard currentResult != nil else { numberOfOperations = 0; return  }
                createNewEquation(with: currentResult!, at: 0)
                numberOfOperations = getNumberOfOperations()
            }
            numberOfOperations = 0
            numberOfSpecialOperations = 0
        }
        result = currentResult
    }
    
    private func createStringArray(){
        elementArray = equation.components(separatedBy: " ")
    }
    private func getNumberOfOperations() -> Int {
        var numberOfOperations = 0
        for element in elementArray {
            if element == "+" || element == "-" || element == "x" || element == "÷" {
                numberOfOperations += 1
            }
        }
        return numberOfOperations
    }
    private func getNumberOfSpecialOperations() -> Int {
        var numberOfSpecialOperations = 0
        for element in elementArray {
            if element == "x" || element == "÷" {
                numberOfSpecialOperations += 1
            }
        }
        return numberOfSpecialOperations
    }
    private func getIndexOfSpecialOperation() -> Int {
        var index = 0
        for element in 0..<elementArray.count {
            if elementArray[element] == "x" || elementArray[element] == "÷" {
                index = element
            }
        }
        return index
    }
    private func getOperationType(from string: String) -> Operation {
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
        guard !elementArray.isEmpty else { return }
        elementArray.remove(at: index)
        elementArray.remove(at: index)
        elementArray.remove(at: index)
        elementArray.insert(String(currentResult), at: index)
    }
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
}
