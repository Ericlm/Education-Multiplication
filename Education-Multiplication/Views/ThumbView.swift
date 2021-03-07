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
    
    /// Indicates whether the view is highlighted, and send the information to the `ThumbLayer`.
    var isHighlighted = false {
        didSet {
            (layer as! ThumbLayer).isHighlighted = isHighlighted
            setNeedsDisplay()
        }
    }
    
    /// The number displayed by the label inside the view.
    var number: Int = 0 {
        didSet {
            numberLabel.text = "\(number)"
        }
    }
    
    /// The label used to display the currently selected number.
    private var numberLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.contentsScale = UIScreen.main.scale
        
        createNumberLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Creates and assigns the `numberLabel`.
    private func createNumberLabel() {
        numberLabel = UILabel(frame: bounds)
        numberLabel.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        numberLabel.textColor = .white
        numberLabel.textAlignment = .center
        numberLabel.text = "\(number)"
        addSubview(numberLabel)
    }
}
