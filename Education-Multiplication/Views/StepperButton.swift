//
//  StepperButton.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import UIKit

@IBDesignable
class StepperButton: BigButton {
    @IBInspectable var topLeft: Bool = false {
        didSet { roundCorners() }
    }
    @IBInspectable var topRight: Bool = false {
        didSet { roundCorners() }
    }
    @IBInspectable var bottomRight: Bool = false {
        didSet { roundCorners() }
    }
    @IBInspectable var bottomLeft: Bool = false {
        didSet { roundCorners() }
    }
    
    private func roundCorners() {
        var maskedCorners = [CACornerMask]()
        if topLeft { maskedCorners.append(.layerMinXMinYCorner) }
        if topRight { maskedCorners.append(.layerMaxXMinYCorner) }
        if bottomRight { maskedCorners.append(.layerMaxXMaxYCorner) }
        if bottomLeft { maskedCorners.append(.layerMinXMaxYCorner) }
        
        layer.maskedCorners = .init(maskedCorners)
    }
    
    override func prepareForInterfaceBuilder() {
        roundCorners()
        super.prepareForInterfaceBuilder()
    }
}
