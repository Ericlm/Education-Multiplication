//
//  ThumbLayer.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 24/02/2021.
//

import UIKit

class ThumbLayer: CALayer {
    var isHighlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(in ctx: CGContext) {
        ctx.setFillColor(isHighlighted ? UIColor.systemYellow.cgColor : UIColor.systemPink.cgColor)
        ctx.fill(bounds)
    }
}
