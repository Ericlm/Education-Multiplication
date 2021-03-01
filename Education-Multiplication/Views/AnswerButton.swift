//
//  AnswerButton.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import UIKit

class AnswerButton: BigButton {
    var numberToDisplay: Int!
    
    var highlightOnAnimator: UIViewPropertyAnimator!
    var highlightOffAnimator: UIViewPropertyAnimator!
    
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
