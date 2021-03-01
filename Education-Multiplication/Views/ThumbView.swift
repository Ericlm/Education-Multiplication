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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.contentsScale = UIScreen.main.scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
