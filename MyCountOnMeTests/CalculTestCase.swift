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
    
    func testGivenNumberOneIs6_WhenAdd7ToNumberOne_ThenResultIs13() {
        let result = calcul.add(number1: 6, with: 7)
        XCTAssertEqual(result, 13)
    }
    func testGivenAnOperatorPlusSpaceAreTheLastElements_WhenCheckingOperator_ThenCanAddOperatorIsFalse() {
        calcul.elements = "1 + "
        XCTAssertFalse(calcul.canAddOperator)
    }
    func testGivenNumberOneIs6_WhenSubstract7ToNumberOne_ThenResultIsMinus1() {
        let result = calcul.substract(number1: 6, with: 7)
        XCTAssertEqual(result, -1)
    }
    func testGivenNumberOneIs6_WhenMultiply7ToNumberOne_ThenResultIs42() {
        let result = calcul.multiply(number1: 6, with: 7)
        XCTAssertEqual(result, 42)
    }
    func testGivenNumberOneIs6_WhenDivide3ToNumberOne_ThenResultIs2() {
        let result = calcul.divide(number1: 6, with: 3)
        XCTAssertEqual(result, 2)
    }
    func testGivenNumberOneIs6_WhenDivide0ToNumberOne_ThenResultIsNil() {
        let result = calcul.divide(number1: 6, with: 0)
        XCTAssertEqual(result, nil)
    }
    func testGivenNumberOneIs7_WhenDivide2ToNumberOne_ThenResultIs3Point5() {
        let result = calcul.divide(number1: 7, with: 2)
        XCTAssertEqual(result, 3.5)
    }

    
    
}
