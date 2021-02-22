//
//  AnswerButton.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import UIKit

@IBDesignable
class AnswerButton: UIButton {
    @IBInspectable private var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }
    
    var numberToDisplay: Int!
    
    var highlightOnAnimator: UIViewPropertyAnimator!
    var highlightOffAnimator: UIViewPropertyAnimator!
    
    override var isHighlighted: Bool {
        didSet {
            animateHighlight()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
    
    private func animateHighlight() {
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.transform = isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
        } completion: { (isFinished) in
            
        }
    }
    
    func playWrongAnswerAnimation() {
        self.isEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = .red
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 50, options: [.curveEaseInOut]) { [unowned self] in
            self.transform = CGAffineTransform(rotationAngle: 0.10)
        }
    }
    
    func reload(animationTime: TimeInterval) {
        isEnabled = false
        self.transform = .identity
        UIView.animate(withDuration: animationTime, delay: 0, options: []) { [unowned self] in
            self.alpha = 0.0
        } completion: { [unowned self] _ in
            setTitle(String(numberToDisplay), for: .normal)
            self.backgroundColor = .systemBlue
            UIView.animate(withDuration: animationTime) {
                self.alpha = 1.0
            } completion: { [unowned self] _ in
                isEnabled = true
            }

        }
    }
}
