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
    
    var canAddOperator : Bool {
        return elements.last != " "
    }
    
    func add(number1 : Double, with number2: Double) -> Double {
        return number1 + number2
    }
    func substract(number1 : Double, with number2: Double) -> Double {
        return number1 - number2
    }
    func multiply(number1 : Double, with number2: Double) -> Double {
        return number1 * number2
    }
    func divide(number1 : Double, with number2: Double) -> Double? {
        if number2 != 0 {
            return number1 / number2
        } else { return nil }
    }
    func equal(){
        let stringArray = elements.components(separatedBy: " ")
        let firstElement = Double(stringArray[0])!
        let operationElement = stringArray[1]
        let secondElement = Double(stringArray[2])!
        var result = Double(0)
        switch operationElement {
        case Operation.add.rawValue : result = add(number1: firstElement, with: secondElement)
        case Operation.minus.rawValue : result = substract(number1: firstElement, with: secondElement)
        case Operation.multiply.rawValue : result = multiply(number1: firstElement, with: secondElement)
        case Operation.divide.rawValue : result = divide(number1: firstElement, with: secondElement) ?? 0
        default: break
        }
        elements.append(" \(result)")
        print(result)
    }
}
