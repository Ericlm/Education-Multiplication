//
//  Preferences.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import Foundation

class Preferences {
    #warning("Preferences are arbitrarily set. They should access UserDefaults instead.")
    static var factorsRange: ClosedRange<Int> {
        get {
            return 1...12
        }
        
        set {
            //Access the user defaults and write to it
        }
    }
    
    static var selectedFactors: [Int] {
        get {
            return [1,2,3,4]
        }
        
        set {
            //Access the user defaults
        }
    }
}
