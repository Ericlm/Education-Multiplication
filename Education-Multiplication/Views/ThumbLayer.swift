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
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setLineWidth(4)
        ctx.addEllipse(in: bounds.insetBy(dx: 2, dy: 2))
        ctx.drawPath(using: .fillStroke)
        
        //ctx.fill(bounds)
    }
}
