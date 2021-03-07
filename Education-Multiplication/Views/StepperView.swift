//
//  StepperView.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import UIKit

@IBDesignable
class StepperView: UIControl {
    /// The label displaying the current count.
    @IBOutlet private var countLabel: UILabel!
    
    var step: Int = 1
    var range: ClosedRange<Int> = 1...10
    var currentValue: Int {
        didSet {
            countLabel.text = String(currentValue)
        }
    }
    
    override init(frame: CGRect) {
        currentValue = 0
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        currentValue = 0
        super.init(coder: coder)
        commonInit()
    }
    
    /// A common initializer to be used in `init(frame:)` and `init(coder:)`.
    private func commonInit() {
        let view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    /// Load the *StepperView* from a Xib file and returns it.
    /// - Returns: The view loaded from the nib file.
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: StepperView.self)
        let nib = UINib(nibName: "StepperView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    @IBAction func upTapped(_ sender: StepperButton) {
        if currentValue < range.max()! {
            currentValue += step
            sendActions(for: .valueChanged)
        }
    }
    
    @IBAction func downTapped(_ sender: StepperButton) {
        if currentValue > range.min()! {
            currentValue -= step
            sendActions(for: .valueChanged)
        }
    }
}
