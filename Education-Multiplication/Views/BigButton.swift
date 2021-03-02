//
//  BigButton.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 23/02/2021.
//

import UIKit

@IBDesignable
class BigButton: UIButton {
    /// The radius applied to every corners of the button.
    @IBInspectable internal var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }
    
    /// The background color of the button.
    @IBInspectable private var color: UIColor {
        get {
            return backgroundColor ?? .systemBlue
        }
        set {
            backgroundColor = newValue
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            animateHighlight()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        commonInit()
        super.prepareForInterfaceBuilder()
    }
    
    /// This function is called in others initializers methods to setup the view in both *Interface Builder* and for the app at runtime.
    private func commonInit() {
        titleLabel?.minimumScaleFactor = 0.6
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.font = UIFont(name: "Chalkduster", size: 40)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    /// Animates the button with a scaling animation when it's highlighted.
    private func animateHighlight() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction]) { [unowned self] in
            self.transform = isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
        } completion: { (isFinished) in
        }
    }
}
