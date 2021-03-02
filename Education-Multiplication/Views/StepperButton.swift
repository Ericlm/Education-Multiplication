//
//  StepperButton.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import UIKit

@IBDesignable
class StepperButton: BigButton {
    /// Should the corner at the top left be rounded by the `cornerRadius` property?
    @IBInspectable var topLeft: Bool = false {
        didSet { roundCorners() }
    }
    /// Should the corner at the top right be rounded by the `cornerRadius` property?
    @IBInspectable var topRight: Bool = false {
        didSet { roundCorners() }
    }
    /// Should the corner at the bottom right be rounded by the `cornerRadius` property?
    @IBInspectable var bottomRight: Bool = false {
        didSet { roundCorners() }
    }
    /// Should the corner at the bottom left be rounded by the `cornerRadius` property?
    @IBInspectable var bottomLeft: Bool = false {
        didSet { roundCorners() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        roundCorners()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        roundCorners()
    }
    
    /// Creates rounded corners for all corners checked in the storyboard.
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
