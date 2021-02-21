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
    
    override var isHighlighted: Bool {
        didSet {
            animateHighlight()
        }
    }
    
    private func animateHighlight() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction) { [unowned self] in
            self.transform = isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
        }
    }
    
    func playWrongAnswerAnimation() {
        self.isEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = .red
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 50, options: [.curveEaseInOut]) { [unowned self] in
            self.transform = CGAffineTransform(rotationAngle: 0.25)
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: []) {
                self.backgroundColor = .darkGray
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }
        }
    }
}
