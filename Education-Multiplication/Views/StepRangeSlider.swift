//
//  StepRangeSlider.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 23/02/2021.
//

import UIKit

class StepRangeSlider: UIControl {
    /// The range in which the values are created.
    private let range: ClosedRange<Int>
    
    /// The current lower value of the slider.
    private(set) var lowerValue: Int
    /// The current upper value of the slider.
    private(set) var upperValue: Int
    
    /// The size of the thumbs to manipulate the slider.
    private let thumbSize = CGSize(width: 40, height: 40)
    /// The layer reprensenting the track behind the two thumbs.
    private let trackLayer = CALayer()
    /// The layer where the steps of the slider are drawn, in respect to the range's length.
    private var rangeStepsLayer: RangeSliderStepsLayer!
    
    /// The `ThumbView` reprensenting the lower value of the range, that can be manipulated to change it.
    private var lowerThumbView: ThumbView!
    /// The `ThumbView` reprensenting the upper value of the range, that can be manipulated to change it.
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
    
    /// Creates the track layer of the view, and assigning it to the `trackLayer` value.
    private func createTrack() {
        let trackWidth = bounds.width - thumbSize.width
        let trackHeight: CGFloat = 12
        let trackOrigin = CGPoint(x: thumbSize.width/2, y: bounds.height/2)
        trackLayer.frame = CGRect(origin: trackOrigin, size: CGSize(width: trackWidth, height: trackHeight))
        trackLayer.backgroundColor = UIColor.systemBlue.cgColor
        layer.addSublayer(trackLayer)
    }
    
    /// Creates the two `ThumbView` of the slider. The views are automatically set to the `lowerValue` and `upperValue` initialized in the initializer method.
    private func createThumbViews() {
        // Creates the two ThumbViews with the given size. (The origin will be evaluated later in the method).
        lowerThumbView = ThumbView(frame: CGRect(origin: .zero, size: thumbSize))
        upperThumbView = ThumbView(frame: CGRect(origin: .zero, size: thumbSize))
        
        // We assign the values to the ThumbViews, so their label display the correct number at start.
        lowerThumbView.number = lowerValue
        upperThumbView.number = upperValue
        
        // We disable user interaction on both views, so the touch events are caught by the slider.
        lowerThumbView.isUserInteractionEnabled = false
        upperThumbView.isUserInteractionEnabled = false
        
        // We set the center of both views to be the center of the track's layer.
        lowerThumbView.center.y = trackLayer.frame.origin.y + trackLayer.frame.height/2
        upperThumbView.center.y = trackLayer.frame.origin.y + trackLayer.frame.height/2
        
        // We normalize both values given the maximum one, allowing us to set the position relative to the track width.
        let normalizedLower = CGFloat(lowerValue - range.min()!) / CGFloat(range.max()!)
        let normalizedUpper = CGFloat(upperValue) / CGFloat(range.max()!)
        
        // We set the center of both views as the track's width multiplied by the normalized value. (For example, 0.5 * trackWidth = middle of the track)
        lowerThumbView.center.x = trackLayer.frame.origin.x + trackLayer.frame.width * normalizedLower
        upperThumbView.center.x = trackLayer.frame.origin.x + trackLayer.frame.width * normalizedUpper
        
        // We add both subviews to the slider, and ask it to update the display.
        addSubview(lowerThumbView)
        addSubview(upperThumbView)
        lowerThumbView.layer.setNeedsDisplay()
        upperThumbView.layer.setNeedsDisplay()
    }
    
    /// Draws small steps (vertical lines) indicating to the user where the thumbs can be positioned.
    private func drawRange() {
        CATransaction.begin()
        rangeStepsLayer = RangeSliderStepsLayer(layer: trackLayer, numberOfSteps: range.count - 1)
        rangeStepsLayer.setNeedsDisplay()
        trackLayer.addSublayer(rangeStepsLayer)
        CATransaction.commit()
    }
}

extension StepRangeSlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchLocation = touch.location(in: self)
        
        // Process the touch to detect if the user wants to move a thumb view.
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
        
        // Process the touch to move the thumb view corresponding to the currently highlighted thumb view.
        if lowerThumbView.isHighlighted {
            let oldLowerValue = lowerValue
            lowerThumbView.center.x = clampPosition(position: touchLocation, isUpThumb: false)
            // We only send action if the new value is different from the current one
            if(oldLowerValue != lowerValue) {
                lowerThumbView.number = lowerValue
                sendActions(for: .valueChanged)
            }
            return true
        } else if upperThumbView.isHighlighted {
            let oldUpperValue = upperValue
            upperThumbView.center.x = clampPosition(position: touchLocation, isUpThumb: true)
            // We only send action if the new value is different from the current one
            if(oldUpperValue != upperValue) {
                upperThumbView.number = upperValue
                sendActions(for: .valueChanged)
            }
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
        // The position translated to a floating value between min and max steps.
        let floatingStep = localPosition.x / rangeStepsLayer.stepSize
        // The position rounded and cast as an integer
        let roundedSteps = Int(floatingStep.rounded())
        
        // To understand the following code, it's crucial to understand that the range is always 1 bigger than the number of steps. This is due to the fact that the steps are the space between each line, and not the lines themself. For example, if we have 1 step, we have to draw 2 lines; 4 steps => 5 lines, etc.
        
        let minimumStep: Int
        if isUpThumb {
            // For the upper thumb, the minimumStep is simply the lowerValue (and it keeps one space with the lower thumb, because the lowerThumb is at lowerValue - 1.
            minimumStep = lowerValue
        } else {
            // For the lower thumb, the minimum is the minimum of the range, minus one.
            minimumStep = range.min()! - 1
        }
        
        let maximumStep: Int
        if isUpThumb {
            // For the upper thumb, the maximum step is the maximum of the range, minus one.
            maximumStep = range.max()! - 1
        } else {
            // For the lower thumb, the maximum step is the upper value, but with -1 to offset the range, and another -1 to have one space with the upper thumb.
            maximumStep = upperValue - 2
        }
        
        // We clamp the step to be always between the minimum and maximum.
        let clampedStep = max(minimumStep, min(roundedSteps, maximumStep))
        
        // We can then update our values, by adding 1 to the clamped step (we need to undo the offset)
        if isUpThumb {
            upperValue = clampedStep + 1
        } else {
            lowerValue = clampedStep + 1
        }
        
        // From the step, we can deduce the position of the step inside the slider.
        let stepPosition = CGFloat(clampedStep) * rangeStepsLayer.stepSize
        let localFramePosition = layer.convert(CGPoint(x: stepPosition, y: trackLayer.frame.midY), from: trackLayer).x
        return localFramePosition
    }
}
