//
//  Multiplication.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import Foundation

struct Multiplication {
    /// The number of factors used wehn generating the multiplication
    private let numberOfFactors: Int
    /// The range in which multiplication's factors can be generated
    private let factorsRange: ClosedRange<Int>
    /// The number of answers the multiplication must generate
    private let numberOfAnswers: Int
    
    /// A tuple describing the operation, separating the factors from the result
    private(set) var operation: (factors: [Int], result: Int)!
    /// An array of all possible answers generated
    private(set) var possibleAnswers = [Int]()
    
    /// The index of the answer inside an array representing all the numbers of the operation.
    /// - Attention: The index is valid for the array where the **result is included**. It is **not valid** for the array representing the factors only.
    private var hiddenIndex: Int!
    /// Represents the operation tuple, but combines the factors and the result, by appending it at the end of the factors' array.
    private var flatOperation: [Int] {
        var operationArray = operation.factors
        operationArray.append(operation.result)
        return operationArray
    }
    /// The direct answer to the operation, **not** the index of the correct answer.
    private var correctAnswer: Int {
        return flatOperation[hiddenIndex]
    }
    
    init(factorsRange: ClosedRange<Int>, numberOfAnswers: Int, numberOfFactors: Int) {
        self.factorsRange = factorsRange
        self.numberOfAnswers = numberOfAnswers
        self.numberOfFactors = numberOfFactors
        
        /*
            We first generate the operation, to later access its factors and result.
            Once we have an operation, we can populate the hiddenIndex with a random index inside the operation.
            Then, we can populate the possibleAnswers array.
         */
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
            possibleAnswers.append(Int.random(in: 1...100))
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
        var factorString = factorsStringArray.reduce(into: "") { (currentString, factor) in
            currentString += "\(factor) x "
        }
        //Remove the last ' x' from the string
        factorString.removeLast(2)
        var resultString = operationStringArray.last!
        resultString = "= \(resultString)"
        
        return factorString.appending(resultString)
    }
}
