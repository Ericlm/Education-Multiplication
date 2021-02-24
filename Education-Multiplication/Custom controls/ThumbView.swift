//
//  ThumbView.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 24/02/2021.
//

import UIKit

class ThumbView: UIView {
    override class var layerClass: AnyClass {
        return ThumbLayer.self
    }
    
    var isHighlighted = false {
        didSet {
            (layer as! ThumbLayer).isHighlighted = isHighlighted
            setNeedsDisplay()
        }
    }
}
