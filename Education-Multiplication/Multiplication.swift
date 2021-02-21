//
//  Multiplication.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import Foundation

struct Multiplication {
    private let factorsRange: ClosedRange<Int>
    private let numberOfAnswers: Int
    private let numberOfFactors: Int
    
    private(set) var operation: (factors: [Int], result: Int)!
    private(set) var possibleAnswers = [Int]()
    
    private var hiddenIndex: Int!
    private var flatOperation: [Int] {
        var operationArray = operation.factors
        operationArray.append(operation.result)
        return operationArray
    }
    private var correctAnswer: Int {
        return flatOperation[hiddenIndex]
    }
    
    init(factorsRange: ClosedRange<Int>, numberOfAnswers: Int, numberOfFactors: Int) {
        self.factorsRange = factorsRange
        self.numberOfAnswers = numberOfAnswers
        self.numberOfFactors = numberOfFactors
        
        generateOperation()
        createHiddenIndex()
        generatePossibleAnswers()
        
        print("Correct answer \(correctAnswer)")
    }
    
    private mutating func generateOperation() {
        var factors = [Int]()
        for _ in 0..<numberOfFactors {
            factors.append(Int.random(in: factorsRange))
        }
        let result = factors.reduce(1) { (currentResult, factor) -> Int in
            currentResult * factor
        }
        operation = (factors, result)
    }
    
    private mutating func createHiddenIndex() {
        let range = 0..<flatOperation.count
        hiddenIndex = Int.random(in: range)
    }
    
    private mutating func generatePossibleAnswers() {
        //We always need one more slot to put the correct answer (we generate only 3 answers if 4 are needed)
        for _ in 1..<numberOfAnswers {
            #warning("We need to ensure that the answers are unique")
            possibleAnswers.append(Int.random(in: 1...300))
        }
        possibleAnswers.append(correctAnswer)
        
        #warning("We need to shuffle the array.")
    }
    
    func isNumberCorrect(_ number: Int) -> Bool {
        return number == correctAnswer
    }
    
    func operationText() -> String {
        var operationStringArray = flatOperation.map { (number) -> String in
            String(number)
        }
        operationStringArray[hiddenIndex] = "?"
        
        let factorsStringArray = operationStringArray.prefix(upTo: operationStringArray.count-1)
        let factorString = factorsStringArray.reduce(into: "") { (currentString, factor) in
            currentString += "\(factor) x "
        }
        var resultString = operationStringArray.last!
        resultString = "= \(resultString)"
        
        return factorString.appending(resultString)
    }
}
