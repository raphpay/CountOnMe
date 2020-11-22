//
//  CalculTestCase.swift
//  MyCountOnMeTests
//
//  Created by Raphaël Payet on 01/11/2020.
//

import XCTest
@testable import MyCountOnMe

class CalculTestCase: XCTestCase {
    var calcul = Calcul()
    override func setUp() {
        calcul = Calcul()
    }
    
    func calculate(equation: String) {
        calcul.equation = equation
        calcul.startCalculationProcess()
    }
    
    func testGivenResultIs3Point5_WhenCheckingIfIsADouble_ThenPropertyIsTrue(){
        calcul.result = 3.5
        XCTAssertTrue(calcul.isResultADouble)
    }
    func testGivenEquationIsNil_WhenCheckingIfCanAddOperator_ThenPropertyIsFalse(){
        XCTAssertFalse(calcul.canAddOperator)
    }
    func testGivenEquationIs3Plus3Equal_WhenCheckingIfCalculIsFinish_ThenPropertyIsTrue(){
        calculate(equation: "3 + 3 =")
        XCTAssertTrue(calcul.isFinished)
    }
    func testGivenEquationIs3Plus_WhenCheckingLastOperatorType_ThenPropertyIsPlus(){
        calcul.equation = "3 +"
        XCTAssertEqual(calcul.lastOperatorType, .plus)
    }
    
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
        calculate(equation: "1 + 2 x 3 x 4 =")
        XCTAssertEqual(calcul.result, 25)
    }
}
