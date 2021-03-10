//
//  Preferences.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import Foundation

class Preferences {
    private static let selectedFactorsKey = "selectedFactors"
    private static let numberOfQuestionsKey = "numberOfQuestions"
    private static let numberOfAnswersKey = "numberOfAnswers"
    private static let numberOfFactorsKey = "numberOfFactors"
    private static let lowerFactorKey = "lowerFactor"
    private static let upperFactorKey = "upperFactor"
    
    static var selectedFactors: [Int] {
        get {
            return UserDefaults.standard.array(forKey: selectedFactorsKey) as? [Int] ?? []
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: selectedFactorsKey)
        }
    }
    
    static var numberOfQuestions: Int {
        get {
            let defaultsValue = UserDefaults.standard.integer(forKey: numberOfQuestionsKey)
            return defaultsValue == 0 ? 10 : defaultsValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: numberOfQuestionsKey)
        }
    }
    
    static var numberOfAnswers: Int {
        get {
            let defaultsValue = UserDefaults.standard.integer(forKey: numberOfAnswersKey)
            return defaultsValue == 0 ? 4 : defaultsValue
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: numberOfAnswersKey)
        }
    }
    
    static var numberOfFactors: Int {
        get {
            let defaultsValue = UserDefaults.standard.integer(forKey: numberOfFactorsKey)
            return defaultsValue == 0 ? 2 : defaultsValue
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: numberOfFactorsKey)
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
            guard UserDefaults.standard.object(forKey: lowerFactorKey) != nil else { return 1 }
            return UserDefaults.standard.integer(forKey: lowerFactorKey)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: lowerFactorKey)
        }
    }
    
    private static var upperFactor: Int {
        get {
            guard UserDefaults.standard.object(forKey: upperFactorKey) != nil else { return 12 }
            return UserDefaults.standard.integer(forKey: upperFactorKey)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: upperFactorKey)
        }
    }
}
