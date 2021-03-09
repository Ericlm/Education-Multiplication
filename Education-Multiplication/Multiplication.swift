//
//  Multiplication.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import Foundation
import GameplayKit

struct Multiplication {
    /// The range of factors a multiplication can be generated with.
    private let factorsRange: ClosedRange<Int>
    /// The number of factors used when generating the multiplication.
    private let numberOfFactors: Int
    /// The factors that can be used to generate the multiplication.
    private let selectedFactors: [Int]
    /// The number of answers the multiplication must generate.
    private let numberOfAnswers: Int
    
    /// An array describing the operation. The result is always appended at the end, so you can access it simply by doing `operation.last`.
    private(set) var operation = [Int]()
    /// An array of all possible answers generated.
    private(set) var possibleAnswers = [Int]()
    
    /// The index of the answer inside the `operation` array.
    private var hiddenIndex: Int!
    /// The direct answer to the operation, **not** the index of the correct answer.
    private var correctAnswer: Int {
        return operation[hiddenIndex]
    }
    
    init(factorsRange: ClosedRange<Int> ,selectedFactors: [Int], numberOfAnswers: Int, numberOfFactors: Int) {
        self.factorsRange = factorsRange
        self.selectedFactors = selectedFactors.isEmpty ? Array(factorsRange) : selectedFactors
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
    }
    
    /// Generates a multiplication and its result, and store them inside the `operation` array.
    ///  This function guarantees that one of the `selectedFactors` is present.
    ///  The other factors are chose randomly inside the `factorsRange` range.
    /// - Note: The result is always the last member.
    private mutating func generateOperation() {
        //We empty the operation before continuing
        operation.removeAll(keepingCapacity: true)
        
        //We add one of the selected factors to the array, to be sure it's always present
        operation.append(selectedFactors.randomElement()!)
        
        //We populate the array with various factors chose in factorsRange
        for _ in 1..<numberOfFactors {
            operation.append(Int.random(in: factorsRange))
        }
        
        //We shuffle the array so that the selected factor is not always first
        operation.shuffle()
        
        //We calculate the result produced by the factors and append it to the operation
        let result = operation.reduce(1) { (currentResult, factor) -> Int in
            currentResult * factor
        }
        operation.append(result)
    }
    
    /// Assign a value to the `hiddenIndex` property. This index is chose randomly inside the `operation` array.
    private mutating func createHiddenIndex() {
        let range = 0..<operation.count
        hiddenIndex = Int.random(in: range)
    }
    
    /// Generates the `possibleAnswers` array given the current operation.
    /// It takes care of making each answer unique, and relative to the fact that the question might ask a factor or a result.
    private mutating func generatePossibleAnswers() {
        possibleAnswers.removeAll(keepingCapacity: true)
        
        // We get the result of the multiplication, and check whether the question wants a factor or the result
        let result = operation.last!
        let isResultHidden = hiddenIndex == operation.count - 1
        
        let bounds = getBounds(isResult: isResultHidden, result: result)
        let distribution = GKShuffledDistribution(lowestValue: bounds.min, highestValue: bounds.max)
        
        // The index starts at 1 because we need the number of answers, minus the correct answer appended at the end
        for _ in 1..<numberOfAnswers {
            var randomAnswer = distribution.nextInt()
            if randomAnswer == correctAnswer {
                randomAnswer = distribution.nextInt()
            }
            possibleAnswers.append(randomAnswer)
        }
        possibleAnswers.append(correctAnswer)
        
        possibleAnswers.shuffle()
    }
    
    private func getBounds(isResult: Bool, result: Int) -> (min: Int, max: Int) {
        //We first determine the lowest bound
        let lowestValue: Int
        
        //If the answer must be generated for the result, we need to take a different approach than for an answer concerning a factor
        if isResult {
            //We set an arbitrary lowest bound when we ask a result
            lowestValue = result == 1 ? 1 : Int(Double(result) * 0.5)
        } else {
            //If we ask for a factor, the lowest bound will be the smallest in the factors range
            lowestValue = factorsRange.min()!
        }
        
        //We then determine the highest bound
        let highestValue: Int
        
        //We take a different approach when we ask for a result or not
        if isResult {
            //Our arbitrary highest is twice the result
            let highBound = Int(Double(result) * 1.5)
            
            //We need to ensure we have a range big enough so that every answer is different
            if highBound - lowestValue < numberOfAnswers {
                highestValue = lowestValue + numberOfAnswers
            } else {
                highestValue = highBound
            }
        } else {
            //We need to ensure we have a range big enough so that every answer is different
            var maxFactor = factorsRange.max()!
            if maxFactor < numberOfAnswers {
                maxFactor = numberOfAnswers
            }
            highestValue = maxFactor
        }
        
        return (lowestValue, highestValue)
    }
    
    /// Check that the given number is the answer to the current multiplication.
    /// - Parameter number: The number to check against the correct answer.
    /// - Returns: `false` if the number is not the correct answer, `true` otherwise.
    func isNumberCorrect(_ number: Int) -> Bool {
        return number == correctAnswer
    }
    
    /// Transform the current multiplication to a readable multiplication question. It processes the operation and takes into account the
    /// `hiddenIndex` to hide the correct answer behind a '**?**' symbol.
    /// - Returns: The operation translated textually, with one of the number hidden.
    func operationText() -> String {
        var operationStringArray = operation.map { (number) -> String in
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
