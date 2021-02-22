//
//  Education_MultiplicationTests.swift
//  Education-MultiplicationTests
//
//  Created by Eric Le Maître on 20/02/2021.
//

import XCTest
@testable import Education_Multiplication

class Education_MultiplicationTests: XCTestCase {

    func testMultiplicationGeneratesCorrectNumberOfFactors() {
        for factorNumber in 1...20 {
            let multiplication = Multiplication(factorsRange: 0...0, selectedFactors: [], numberOfAnswers: 1, numberOfFactors: factorNumber)
            let factorsCount = multiplication.operation.count - 1
            XCTAssertEqual(factorNumber, factorsCount)
        }
    }

    func testMultiplicationResultIsCorrect() {
        for factor in 1...20 {
            let multiplication = Multiplication(factorsRange: 1...factor, selectedFactors: [], numberOfAnswers: 1, numberOfFactors: 2)
            let result = multiplication.operation.last!
            let manualResult = multiplication.operation[0] * multiplication.operation[1]
            XCTAssertEqual(result, manualResult)
        }
    }
    
    func testSelectedFactorIsInMultiplication() {
        for selectedFactor in 1...20 {
            let multiplication = Multiplication(factorsRange: 1...20, selectedFactors: [selectedFactor], numberOfAnswers: 1, numberOfFactors: 2)
            XCTAssertNotNil(multiplication.operation.firstIndex(of: selectedFactor))
        }
    }
    
    func testOneOfSelectedFactorsIsAlwaysPresentInMultiplication() {
        for numberOfSelectedFactors in 1...20 {
            let selectedFactors = Array(1...numberOfSelectedFactors)
            let multiplication = Multiplication(factorsRange: 1...20, selectedFactors: selectedFactors, numberOfAnswers: 1, numberOfFactors: 2)
            
            var isContained = false
            for (index, factor) in multiplication.operation.enumerated() {
                if index != multiplication.operation.count - 1 && selectedFactors.contains(factor) {
                    isContained = true
                }
            }
            
            XCTAssert(isContained)
        }
    }
    
    func testOperationTextContainsSelectedFactor() {
        let multiplication = Multiplication(factorsRange: 1...20, selectedFactors: [5], numberOfAnswers: 2, numberOfFactors: 2)
        let text = multiplication.operationText()
        XCTAssertNotNil(text.firstIndex(of: "5"))
    }
    
    func testOperationTextContainsQuestionMark() {
        let multiplication = Multiplication(factorsRange: 1...20, selectedFactors: [5], numberOfAnswers: 2, numberOfFactors: 2)
        let text = multiplication.operationText()
        XCTAssertNotNil(text.firstIndex(of: "?"))
    }
    
    func testOperationTextContainsEqualSign() {
        let multiplication = Multiplication(factorsRange: 1...9, selectedFactors: [], numberOfAnswers: 2, numberOfFactors: 2)
        let text = multiplication.operationText()
        XCTAssertNotNil(text.firstIndex(of: "="))
    }
}
