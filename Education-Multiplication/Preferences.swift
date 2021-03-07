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
            #warning("Selected factors changed")
            //return UserDefaults.standard.array(forKey: "selectedFactors") as? [Int] ?? Array(1...12)
            return [1,2,5,10]
        }
        
        set {
            fatalError("SelectedFactors writing to UserDefaults not implemented")
        }
    }
    
    static var numberOfQuestions: Int {
        get {
            #warning("Number of questions changed")
//            let defaultsValue = UserDefaults.standard.integer(forKey: "numberOfQuestions")
//            return defaultsValue == 0 ? 10 : defaultsValue
            return 5
        }
        set {
            fatalError("NumberOfQuestions writing to UserDefaults not implemented")
        }
    }
    
    static var numberOfAnswers: Int {
        get {
            let defaultsValue = UserDefaults.standard.integer(forKey: "numberOfAnswers")
            return defaultsValue == 0 ? 4 : defaultsValue
        }
        set {
            fatalError("NumberOfAnswers writing to UserDefaults not implemented")
        }
    }
    
    static var numberOfFactors: Int {
        get {
            let defaultsValue = UserDefaults.standard.integer(forKey: "numberOfFactors")
            return defaultsValue == 0 ? 2 : defaultsValue
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
            guard UserDefaults.standard.object(forKey: "lowerFactor") != nil else { return 1 }
            return UserDefaults.standard.integer(forKey: "lowerFactor")
        }
        
        set {
            fatalError("LowerFactor writing to UserDefaults not implemented")
        }
    }
    
    private static var upperFactor: Int {
        get {
            guard UserDefaults.standard.object(forKey: "upperFactor") != nil else { return 12 }
            return UserDefaults.standard.integer(forKey: "upperFactor")
        }
        
        set {
            fatalError("UpperFactor writing to UserDefaults not implemented")
        }
    }
}
