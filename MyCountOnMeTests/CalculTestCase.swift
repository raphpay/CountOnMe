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
    //MARK: - Computed Properties test
    func testGivenEquationIs1Plus_WhenPlusIsTapped_ThenCanAddOperatorIsFalse(){
        calcul.equation = "1 + "
        XCTAssertFalse(calcul.canAddOperator)
    }
    func testGivenResultIs3_WhenCheckingProperty_ThenCalculationIsFinishedIsTrue(){
        calcul.result = 3
        XCTAssertTrue(calcul.isFinished)
    }
    func testGivenCalculIsNil_WhenCheckingProperty_ThenCalculationIsFinishedIsFalse(){
        XCTAssertFalse(calcul.isFinished)
    }
    func testGivenResultIsNil_WhenCheckingProperty_ThenResultIsADoubleIsFalse(){
        XCTAssertFalse(calcul.resultIsADouble)
    }
    func testGivenResultIs3_WhenCheckingProperty_ThenResultIsADoubleIsFalse(){
        calcul.result = 3
        XCTAssertFalse(calcul.resultIsADouble)
    }
    func testGivenResultIs3Point5_WhenCheckingProperty_ThenResultIsADoubleIsTrue(){
        calcul.result = 3.5
        XCTAssertTrue(calcul.resultIsADouble)
    }
    // MARK: - Simple equations test
    func testGivenNumberOneIs6_WhenAdding3_ThenResultIs9(){
        calcul.equation = "6 + 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 9)
    }
    func testGivenNumberOneIs6_WhenSubstracting3_ThenResultIs3(){
        calcul.equation = "6 - 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 3)
    }
    func testGivenNumberOneIs6_WhenSubstracting9_ThenResultIsMinus3(){
        calcul.equation = "6 - 9"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, -3)
    }
    func testGivenNumberOneIs6_WhenMultiplyingBy3_ThenResultIs18(){
        calcul.equation = "6 x 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 18)
    }
    func testGivenNumberOneIs6_WhenDividingBy3_ThenResultIs2(){
        calcul.equation = "6 ÷ 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 2)
    }
    func testGivenNumberOneIs6_WhenDividingBy4_ThenResultIs1Point5(){
        calcul.equation = "6 ÷ 4"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 1.5)
    }
    func testGivenEquationIs6DividedBy0_WhenCalculating_ThenResultIsNil(){
        calcul.equation = "6 ÷ 0"
        calcul.calculate(operation: calcul.equation)
        XCTAssertNil(calcul.result)
    }
    
    // MARK: - Multiple Operation Equation test
    func testGivenEquationIs3Plus3Plus3_WhenCalculating_ThenResultIs9(){
        calcul.equation = "3 + 3 + 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 9)
    }
    func testGivenEquationIs3Plus3Minus3_WhenCalculating_ThenResultIs3(){
        calcul.equation = "3 + 3 - 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 3)
    }
    func testGivenEquationIs1Plus2MultipliedBy3_WhenCalculating_ThenResultIs7(){
        calcul.equation = "1 + 2 x 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 7)
    }
    func testGivenEquationIs1Minus2Plus3MultipliedBy4_WhenCalculating_ThenResultIs11(){
        calcul.equation = "1 - 2 + 3 x 4"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 11)
    }
    func testGivenEquationIs9MutipliedBy2DividedBy3_WhenCalculating_ThenResultIs6(){
        calcul.equation = "9 x 2 ÷ 3"
        calcul.calculate(operation: calcul.equation)
        XCTAssertEqual(calcul.result, 6)
    }
    func testGivenEquationIs1Plus2DividedBy0_WhenCalculating_ThenResultIsNil(){
        calcul.equation = "1 + 2 ÷ 0"
        calcul.calculate(operation: calcul.equation)
        XCTAssertNil(calcul.result)
    }
}
