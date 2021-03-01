//
//  RangeSlider.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 23/02/2021.
//

import UIKit

class StepRangeSlider: UIControl {
    private let range: ClosedRange<Int>
    
    private(set) var lowerValue: Int
    private(set) var upperValue: Int
    
    private let thumbSize = CGSize(width: 40, height: 40)
    private let trackLayer = CALayer()
    private var rangeStepsLayer: RangeSliderStepsLayer!
    
    private var lowerThumbView: ThumbView!
    private var upperThumbView: ThumbView!
    
    init(frame: CGRect, range: ClosedRange<Int>, lowerValue: Int? = nil, upperValue: Int? = nil) {
        self.range = range
        self.lowerValue = lowerValue ?? range.min()!
        self.upperValue = upperValue ?? range.max()!
        
        super.init(frame: frame)
        
        createTrack()
        createThumbViews()
        drawRange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTrack() {
        trackLayer.frame = bounds.insetBy(dx: thumbSize.width/2, dy: bounds.height / 3)
        trackLayer.backgroundColor = UIColor.systemBlue.cgColor
        layer.addSublayer(trackLayer)
    }
    
    private func createThumbViews() {
        lowerThumbView = ThumbView(frame: CGRect(origin: .zero, size: thumbSize))
        lowerThumbView.isUserInteractionEnabled = false
        lowerThumbView.center.y = trackLayer.frame.origin.y + trackLayer.frame.height/2
        let normalizedLower = CGFloat(lowerValue) / CGFloat(range.max()!)
        lowerThumbView.center.x = trackLayer.frame.origin.x + trackLayer.frame.width * normalizedLower
        addSubview(lowerThumbView)
        lowerThumbView.layer.setNeedsDisplay()
        
        upperThumbView = ThumbView(frame: CGRect(origin: .zero, size: thumbSize))
        upperThumbView.isUserInteractionEnabled = false
        upperThumbView.center.y = trackLayer.frame.origin.y + trackLayer.frame.height/2
        let normalizedUpper = CGFloat(upperValue) / CGFloat(range.max()!)
        upperThumbView.center.x = trackLayer.frame.origin.x + trackLayer.frame.width * CGFloat(normalizedUpper)
        addSubview(upperThumbView)
        upperThumbView.layer.setNeedsDisplay()
    }
    
    private func drawRange() {
        CATransaction.begin()
        rangeStepsLayer = RangeSliderStepsLayer(layer: trackLayer)
        rangeStepsLayer.setNeedsDisplay()
        trackLayer.addSublayer(rangeStepsLayer)
        CATransaction.commit()
    }
}

// TODO: - Start with continuous update, then step update, then max and min for each value
extension StepRangeSlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchLocation = touch.location(in: self)
        
        if lowerThumbView.frame.contains(touchLocation) {
            lowerThumbView.isHighlighted = true
            return true
        } else if upperThumbView.frame.contains(touchLocation) {
            upperThumbView.isHighlighted = true
            return true
        }
        
        return false
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchLocation = touch.location(in: self)
        
        if lowerThumbView.isHighlighted {
            lowerThumbView.center.x = clampPosition(position: touchLocation, isUpThumb: false)
            return true
        } else if upperThumbView.isHighlighted {
            upperThumbView.center.x = clampPosition(position: touchLocation, isUpThumb: true)
            return true
        }
        
        return false
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbView.isHighlighted = false
        upperThumbView.isHighlighted = false
    }
    
    private func clampPosition(position: CGPoint, isUpThumb: Bool) -> CGFloat {
        // We convert the position from the view's layer to the trackLayer
        let localPosition = trackLayer.convert(position, from: layer)
        let floatingStep = localPosition.x / rangeStepsLayer.stepSize
        let roundedSteps = Int(floatingStep.rounded())
        
        let minimumPosition: Int
        if isUpThumb {
            minimumPosition = lowerValue + 1
        } else {
            minimumPosition = range.min()! - 1
        }
        let maximumPosition: Int
        if isUpThumb {
            maximumPosition = range.max()!
        } else {
            maximumPosition = upperValue - 1
        }
        
        //let minimumPosition = range.min()! - 1
        //let maximumPosition = range.max()!
        let clampedStep = max(minimumPosition, min(roundedSteps, maximumPosition))
        
        if isUpThumb {
            upperValue = clampedStep
        } else {
            lowerValue = clampedStep
        }
        
        let stepPosition = CGFloat(clampedStep) * rangeStepsLayer.stepSize
        let localFramePosition = layer.convert(CGPoint(x: stepPosition, y: trackLayer.frame.midY), from: trackLayer).x
        
        return localFramePosition
    }
}
