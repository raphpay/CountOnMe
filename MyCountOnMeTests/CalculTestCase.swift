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
    
    func testGivenResultIs9_WhenCheckingIfResultIsADouble_ThenPropertyIsFalse(){
        calcul.result = 9
        XCTAssertFalse(calcul.isResultADouble)
    }
    func testGivenResultIsNil_WhenCheckingIsResultIsADouble_ThenPropertyIsFalse(){
        XCTAssertFalse(calcul.isResultADouble)
    }
    func testGivenEquationIs3Plus3_WhenCheckingIfCalculIsPossible_ThenPropertyIsTrue(){
        calcul.elements = ["3", "+", "3"]
        XCTAssertTrue(calcul.isCalculationPossible)
    }
    func testGivenEquationIs3Plus3Multiplied3_WhenCheckingLastOperator_ThenLastOperatorIsMultiply(){
        calcul.elements = ["3", "+", "3", "x", "3"]
        XCTAssertEqual(calcul.lastOperatorType, .multiply)
    }
    func testGivenEquationIs3Plus3MultipliedBy3_WhenCheckingIflastOperatorHasPriority_ThenPropertyIsTrue(){
        calcul.elements = ["3", "+", "3", "x", "3"]
        XCTAssertTrue(calcul.isLastOperatorHasPriority)
    }
    func testGivenEquationIs3Plus3Minus3_WhenCheckingIflastOperatorHasPriority_ThenPropertyIsFalse(){
        calcul.elements = ["3", "+", "3", "-", "3"]
        XCTAssertFalse(calcul.isLastOperatorHasPriority)
    }
    func testGivenEquationIs3Plus3_WhenGettingLastOperatorIndex_ThenIndexIs1() {
        calcul.elements = ["3", "+", "3"]
        XCTAssertEqual(calcul.lastOperatorIndex, 1)
    }
    func testGivenEquationIs3Plus_WhenGettingLastOperatorIndex_ThenPropertiesAreNil(){
        calcul.elements = ["3", "+"]
        XCTAssertNil(calcul.lastOperatorIndex)
        XCTAssertNil(calcul.lastOperatorType)
    }
    func testGivenElementCountIs5AndLastOperatorIsEqual_WhenCheckingIfEquationIsReduced_ThenPropertyIsTrue(){
        calcul.elements = ["3", "+", "3", "=", ""]
        XCTAssertTrue(calcul.isEquationReduced)
    }
    func testGivenElementCountIs3AndLastOperatorIsEqual_WhenCheckingIfEquationIsFinished_ThenPropertyIsTrue(){
        calcul.elements = ["3", "=", ""]
        XCTAssertTrue(calcul.isEquationFinished)
    }
    func testGivenEquationIs3Plus3_WhenCalculating_ThenResultIs6(){
        calcul.savedEquation = "3 + 3 = "
        calcul.startCalculationProcess()
        XCTAssertEqual(calcul.result, 6)
    }
    func testGivenEquationIs3Minus3_WhenCalculating_ThenResultIs0(){
        calcul.savedEquation = "3 - 3 = "
        calcul.startCalculationProcess()
        XCTAssertEqual(calcul.result, 0)
    }
    func testGivenEquationIs3MultipliedBy3_WhenCalculating_ThenResultIs9(){
        calcul.savedEquation = "3 x 3 = "
        calcul.startCalculationProcess()
        XCTAssertEqual(calcul.result, 9)
    }
    func testGivenEquationIs3DividedBy3_WhenCalculating_ThenResultIs1(){
        calcul.savedEquation = "3 ÷ 3 = "
        calcul.startCalculationProcess()
        XCTAssertEqual(calcul.result, 1)
    }
    func testGivenEquationIs3DividedBy0_WhenCalculating_ThenResultIsNil(){
        calcul.savedEquation = "3 ÷ 0 = "
        calcul.startCalculationProcess()
        XCTAssertNil(calcul.result)
    }
    func testGivenEquationIs1Plus2MultipliedBy3_WhenCalculating_ThenResultIs7(){
        calcul.savedEquation = "1 + 2 x 3 ="
        calcul.startCalculationProcess()
        guard let result = calcul.result else { return }
        XCTAssertEqual(result, 7)
    }
}
