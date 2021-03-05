//
//  BackgroundLabel.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 05/03/2021.
//

import UIKit

@IBDesignable
class BackgroundLabel: UILabel {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        super.drawText(in: rect.inset(by: insets))
    }
}
