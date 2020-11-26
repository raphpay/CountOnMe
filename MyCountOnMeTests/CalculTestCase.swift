//
//  CalculTestCase.swift
//  MyCountOnMeTests
//
//  Created by Raphaël Payet on 01/11/2020.
//

import XCTest
@testable import MyCountOnMe


//internal var lastOperatorType: OperatorType? { get }
//
//internal func startCalculationProcess()

class CalculTestCase: XCTestCase {
    // MARK: - Setup
    var calcul = Calcul()
    override func setUp() {
        calcul = Calcul()
    }
    
    // MARK: - Helper Methods
    func calculate(equation: String) {
        if calcul.equation == "" {
            calcul.equation = equation
        } else {
            calcul.equation.append(equation)
        }
        calcul.startCalculationProcess()
    }
    
    // MARK: - Test Properties
    // Here we check that all accessible properties return the right information
    func testGivenResultIs3Point5_WhenCheckingIfIsADouble_ThenPropertyIsTrue(){
        calcul.result = 3.5
        XCTAssertTrue(calcul.isResultADouble)
    }
    func testGivenResultIsNil_WhenCheckingIfADouble_ThenPropertyIsFalse(){
        XCTAssertFalse(calcul.isResultADouble)
    }
    func testGivenEquationIsNil_WhenCheckingIfCanAddOperator_ThenPropertyIsFalse(){
        XCTAssertFalse(calcul.canAddOperator)
    }
    func testGivenEquationIs3Plus3_WhenCheckingIfCanAddOperator_ThenPropertyIsFalse(){
        calcul.equation = "3 + 3"
        XCTAssertTrue(calcul.canAddOperator)
    }
    func testGivenEquationIs3Plus3Equal_WhenCheckingIfCalculIsFinish_ThenPropertyIsTrue(){
        calculate(equation: "3 + 3 =")
        XCTAssertTrue(calcul.isFinished)
    }
    func testGivenEquationIs3Plus_WhenCheckingLastOperatorType_ThenPropertyIsPlus(){
        calcul.equation = "3 +"
        XCTAssertEqual(calcul.lastOperatorType, .plus)
    }
    func testGivenEquationIsNil_WhenCheckingLastOperatorType_ThenPropertyIsNil(){
        XCTAssertNil(calcul.lastOperatorType)
    }
    
    // MARK: - Test Calculation Process
    // Here we check that all accessible methods return the good result, no latter the length of the equation
    func testGivenEquationIs3Plus3_WhenCalculating_ThenResultIs6(){
        calculate(equation: "3 + 3 =")
        XCTAssertEqual(calcul.result, 6)
    }
    func testGivenEquationIs3Minus3_WhenCalculating_ThenResultIs0(){
        calculate(equation: "3 - 3 =")
        XCTAssertEqual(calcul.result, 0)
    }
    func testGivenEquationIs3DividedBy3_WhenCalculating_ThenResultIs1(){
        calculate(equation: "3 ÷ 3 =")
        XCTAssertEqual(calcul.result, 1)
    }
    func testGivenEquationIs3DividedBy0_WhenCalculating_ThenResultIsNil(){
        calculate(equation: "3 ÷ 0 =")
        XCTAssertNil(calcul.result)
    }
    func testGivenEquationIs3MultipliedBy3_WhenCalculating_ThenResultIs9(){
        calculate(equation: "3 x 3 =")
        XCTAssertEqual(calcul.result, 9)
    }
    func testGivenEquationIs1Plus2MultipliedBy3MultipliedBy4_WhenCalculating_ThenResultIs25(){
        calculate(equation: "1 + ")
        calculate(equation: "2 x ")
        calculate(equation: "3 x ")
        calculate(equation: "4 = ")
        XCTAssertEqual(calcul.result, 25)
    }
    func testGivenEquationIs3Plus3Plus3_WhenCalculating_ThenResultIs9(){
        calculate(equation: "3 + ")
        calculate(equation: "3 + ")
        calculate(equation: "3 =")
        XCTAssertEqual(9, calcul.result)
    }
    func testGivenEquationIs3Plus_WhenCalculating_ThenResultIsNil(){
        calculate(equation: "3 + ")
        XCTAssertNil(calcul.result)
    }
}
