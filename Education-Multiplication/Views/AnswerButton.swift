//
//  AnswerButton.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import UIKit

class AnswerButton: BigButton {
    private var _isEnabled = true
    override var isEnabled: Bool {
        get {
            return _isEnabled
        }
        set {
            _isEnabled = newValue
        }
    }
    
    /// The number to be displayed inside the button.
    var numberToDisplay: Int!
    
    /// Plays an animation for a wrong answer. The button will shake and wiggle.
    func playWrongAnswerAnimation() {
        self.isEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = .red
        }
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 50, options: [.curveEaseInOut]) { [unowned self] in
            self.transform = CGAffineTransform(rotationAngle: 0.10)
        }
    }
    
    /// Changes the number inside the button and resets the button with animations.
    /// - Parameter animationTime: The time the animation should take to complete.
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
