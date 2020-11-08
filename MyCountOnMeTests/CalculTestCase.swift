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
    
    func testGivenNumberOneIs7_WhenAdding3_ThenResultIs9(){
        calcul.elements = "6 + 3"
        calcul.calculate()
        XCTAssertEqual(calcul.result, 9)
    }
    
    func testGivenNumberOneIs6_WhenSubstracting3_ThenResultIs3(){
        calcul.elements = "6 - 3"
        calcul.calculate()
        XCTAssertEqual(calcul.result, 3)
    }
    
    func testGivenNumberOneIs6_WhenMultiplying3_ThenResultIs18(){
        calcul.elements = "6 x 3"
        calcul.calculate()
        XCTAssertEqual(calcul.result, 18)
    }
    func testGivenNumberOneIs6_WhenDividingBy3_ThenResultIs2(){
        calcul.elements = "6 ÷ 3"
        calcul.calculate()
        XCTAssertEqual(calcul.result, 2)
    }
    func testGivenNumberOneIs7_WhenDividingBy4_ThenResultIs1Point75(){
        calcul.elements = "7 ÷ 4"
        calcul.calculate()
        XCTAssertEqual(calcul.result, 1.75)
    }
    
    func testGivenNumberOneIs7_WhenDividingBy0_ThenResultIsNil(){
        calcul.elements = "7 ÷ 0"
        calcul.calculate()
        XCTAssertNil(calcul.result)
    }
    
    func testGivenAnOperatorPlusSpaceAreTheLastElements_WhenCheckingOperator_ThenCanAddOperatorIsFalse() {
        calcul.elements = "1 + "
        XCTAssertFalse(calcul.canAddOperator)
    }
}
