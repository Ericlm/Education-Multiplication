//
//  Preferences.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import Foundation

#warning("Preferences are arbitrarly set")
class Preferences {
    static var selectedFactors: [Int] {
        get {
            return [1,2,3,4]
        }
        
        set {
            fatalError("SelectedFactors writing to UserDefaults not implemented")
        }
    }
    
    static var numberOfQuestions: Int {
        get {
            return 5
        }
        set {
            fatalError("NumberOfQuestions writing to UserDefaults not implemented")
        }
    }
    
    static var numberOfAnswers: Int {
        get {
            return 4
        }
        set {
            fatalError("NumberOfAnswers writing to UserDefaults not implemented")
        }
    }
    
    static var numberOfFactors: Int {
        get {
            return 2
        }
        
        set {
            fatalError("NumberOfFactors writing to UserDefaults not implemented")
        }
    }
    
    static var factorsRange: ClosedRange<Int> {
        get {
            return lowerFactor...upperFactor
        }
        
        set {
            lowerFactor = newValue.min()!
            upperFactor = newValue.max()!
        }
    }
    
    private static var lowerFactor: Int {
        get {
            return 1
        }
        
        set {
            fatalError("LowerFactor writing to UserDefaults not implemented")
        }
    }
    
    private static var upperFactor: Int {
        get {
            return 12
        }
        
        set {
            fatalError("UpperFactor writing to UserDefaults not implemented")
        }
    }
}
