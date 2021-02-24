//
//  RangeSlider.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 23/02/2021.
//

import UIKit

class StepRangeSlider: UIControl {
    private let range: ClosedRange<Int>
    private let lowerValue = 0
    private let upperValue = 0.8
    
    private let thumbSize = CGSize(width: 50, height: 50)
    private let trackLayer = CALayer()
    private var lowerThumbView: ThumbView!
    private var upperThumbView: ThumbView!
    
    init(frame: CGRect, range: ClosedRange<Int>) {
        self.range = range
        super.init(frame: frame)
        
        createTrack()
        createThumbViews()
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
        lowerThumbView.center.x = trackLayer.frame.origin.x + trackLayer.frame.width * CGFloat(lowerValue)
        addSubview(lowerThumbView)
        lowerThumbView.layer.setNeedsDisplay()
        
        upperThumbView = ThumbView(frame: CGRect(origin: .zero, size: thumbSize))
        upperThumbView.isUserInteractionEnabled = false
        upperThumbView.center.y = trackLayer.frame.origin.y + trackLayer.frame.height/2
        upperThumbView.center.x = trackLayer.frame.origin.x + trackLayer.frame.width * CGFloat(upperValue)
        addSubview(upperThumbView)
        upperThumbView.layer.setNeedsDisplay()
    }
}

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
            return true
        } else if upperThumbView.isHighlighted {
            return true
        }
        
        return false
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbView.isHighlighted = false
        upperThumbView.isHighlighted = false
    }
}
