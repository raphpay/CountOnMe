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
    
    override  func setUp() {
        calcul = Calcul()
    }

    // MARK: - Computed Properties
    func testGivenEquationIs3Plus3_WhenChekingProperty_ThenIsFinishedIsTrue(){
        calcul.result = 3
        XCTAssertTrue(calcul.isFinished)
    }
    func testGivenEquationCountIs3_WhenTappingPlus_ThenCanReduceOperationIsTrue(){
        calcul.equation = "1 + 3 +"
        calcul.lastOperatorType = .plus
        calcul.createArray(from: calcul.equation)
        XCTAssertTrue(calcul.canReduceOperation)
    }
    func testGivenEquationCountIs3_WhenTappingMultiply_ThenCanReduceOperationIsFalse(){
        calcul.equation = "1 + 3 x"
        calcul.lastOperatorType = .multiply
        calcul.createArray(from: calcul.equation)
        XCTAssertFalse(calcul.canReduceOperation)
    }
    func testGivenResultIs3Point2_WhenCheckingProperty_ThenResultIsADoubleIsTrue(){
        calcul.result = 3.2
        XCTAssertTrue(calcul.resultIsADouble)
    }
    // MARK: - Simple Calculs
    func testGivenEquationIs3Plus3_WhenCalculating_ThenResultIs6(){
        calcul.equation = "3 + 3"
        calcul.finish(calcul.equation)
        XCTAssertEqual(calcul.result, 6)
    }
    func testGivenEquationIs4Minus3_WhenCalculating_ThenResultIs1(){
        calcul.equation = "4 - 3"
        calcul.finish(calcul.equation)
        XCTAssertEqual(calcul.result, 1)
    }
    func testGivenEquationIs4MultipliedBy3_WhenCalculating_ThenResultIs12(){
        calcul.equation = "4 x 3"
        calcul.finish(calcul.equation)
        XCTAssertEqual(calcul.result, 12)
    }
    func testGivenEquationIs6DividedBy3_WhenCalculating_ThenResultIs2(){
        calcul.equation = "6 ÷ 3"
        calcul.finish(calcul.equation)
        XCTAssertEqual(calcul.result, 2)
    }
    func testGivenEquationIs6DividedBy0_WhenCalculating_ThenResultIsNil(){
        calcul.equation = "6 ÷ 0"
        calcul.finish(calcul.equation)
        XCTAssertNil(calcul.result)
    }
    
    func testGivenEquationIs3Plus3_WhenTappingPlus_ThenCalculatedEquationIs6Plus(){
        calcul.equation = "3 + 3 +"
        calcul.calculate()
        XCTAssertEqual(calcul.calculatedEquation, "6.0 +")
    }
    func testGivenEquationIs3Plus3_WhenTappingMinus_ThenCalculatedEquationIs6Minus(){
        calcul.equation = "3 + 3 -"
        calcul.calculate()
        XCTAssertEqual(calcul.calculatedEquation, "6.0 -")
    }
    func testGivenEquationIs3Plus3_WhenTappingMultiply_ThenCalculatedEquationIs6Minus(){
        calcul.equation = "3 + 3 x"
        calcul.calculate()
        XCTAssertEqual(calcul.calculatedEquation, "3 + 3 x")
    }
    
    // MARK: - Complex Calculs
    func testGivenEquationIs3Plus4MultipliedBy2_WhenCalculating_ThenResultIs11(){
        calcul.equation = "3 + 4 x 2"
        calcul.finish(calcul.equation)
        XCTAssertEqual(calcul.result, 11)
    }
}
