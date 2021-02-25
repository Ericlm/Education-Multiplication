//
//  RangeSliderSteps.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 24/02/2021.
//

import UIKit

class RangeSliderStepsLayer: CALayer {
    private let strokeWidth: CGFloat = 5
    private let numberOfSteps = 12
    
    var stepSize: CGFloat {
        get { return bounds.width / CGFloat(numberOfSteps) }
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        if let layer = layer as? CALayer {
            let width = layer.bounds.width// + strokeWidth
            let xOrigin = layer.bounds.minX - strokeWidth / 2
            
            frame = CGRect(x: xOrigin, y: layer.bounds.minY, width: width, height: layer.bounds.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        for i in 0...numberOfSteps {
            strokeUnit(context: ctx, step: i)
        }
    }
    
    private func strokeUnit(context ctx: CGContext, step: Int) {
        let xPosition = stepSize * CGFloat(step) + strokeWidth/2
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: xPosition, y: 0))
        linePath.addLine(to: CGPoint(x: xPosition, y: bounds.maxY * 1.2))
        line.path = linePath.cgPath
        line.strokeColor = UIColor.white.cgColor
        line.lineWidth = strokeWidth
        line.lineJoin = .round
        addSublayer(line)
    }
}
