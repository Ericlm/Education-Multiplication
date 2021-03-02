//
//  FadeColorNavigationAnimator.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import UIKit

class FadeColorNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let presenting: Bool
    
    init(isPresenting: Bool) {
        presenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let container = transitionContext.containerView
        if presenting {
            toView.transform = CGAffineTransform(translationX: 0, y: container.frame.height)
            container.addSubview(toView)
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            if self.presenting {
                toView.transform = .identity
                fromView.transform = CGAffineTransform(translationX: 0, y: -container.frame.height)
            } else {
                fromView.alpha = 1.0
                toView.alpha = 1.0
            }
        } completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
    }
}
