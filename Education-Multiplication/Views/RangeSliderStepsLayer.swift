//
//  RangeSliderStepsLayer.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 24/02/2021.
//

import UIKit

class RangeSliderStepsLayer: CALayer {
    /// The width of the stroke used to draw the line.
    private let strokeWidth: CGFloat = 5
    /// The number of steps to be drawn.
    /// - Note: This is **not** the number of lines, but the number of steps.
    private let numberOfSteps: Int
    
    /// Gives the size of one step, relative to the current layer width.
    var stepSize: CGFloat {
        get { return bounds.width / CGFloat(numberOfSteps) }
    }
    
    /// Initialize the steps layer with a given number of steps to be drawn.
    /// - Parameters:
    ///   - layer: The layer from which custom fields should be copied.
    ///   - numberOfSteps: The number of steps the layer should draw.
    /// - Note: The number of steps does **not** represent the number of lines to be drawn, but the number of spaces.
    init(layer: Any, numberOfSteps: Int) {
        self.numberOfSteps = numberOfSteps
        super.init(layer: layer)
        
        if let layer = layer as? CALayer {
            let width = layer.bounds.width
            let xOrigin = layer.bounds.minX - strokeWidth / 2
            
            frame = CGRect(x: xOrigin, y: layer.bounds.minY, width: width, height: layer.bounds.height)
        }
    }
    
    // This method is only implemented to allow Xcode to draw the layer when using the frame debugger.
    override init(layer: Any) {
        self.numberOfSteps = 11
        super.init(layer: layer)
        
        if let layer = layer as? CALayer {
            let width = layer.bounds.width
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
    
    /// Draws a single unit inside the layer, using a `CAShapeLayer`.
    /// - Parameters:
    ///   - ctx: The `CoreGraphics` context to use when drawing.
    ///   - step: The current step to draw.
    private func strokeUnit(context ctx: CGContext, step: Int) {
        let xPosition = stepSize * CGFloat(step) + strokeWidth/2
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: xPosition, y: 0))
        linePath.addLine(to: CGPoint(x: xPosition, y: bounds.maxY))
        line.path = linePath.cgPath
        line.strokeColor = UIColor.white.cgColor
        line.lineWidth = strokeWidth
        line.lineJoin = .round
        addSublayer(line)
    }
}
