//
//  SlideNavigationAnimator.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 23/02/2021.
//

import UIKit

class HorizontalSlideNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let presenting: Bool
    
    init(presenting: Bool) {
        self.presenting = presenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let container = transitionContext.containerView
        if presenting {
            toView.transform = CGAffineTransform(translationX: container.frame.width, y: 0)
            container.addSubview(toView)
        } else {
            toView.frame = CGRect(x: -container.frame.width, y: 0, width: container.frame.width, height: container.frame.height)
            toView.transform = CGAffineTransform(translationX: -container.frame.width, y: 0)
            container.addSubview(toView)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseInOut]) {
            if self.presenting {
                toView.transform = .identity
                fromView.transform = CGAffineTransform(translationX: -container.frame.width, y: 0)
            } else {
                fromView.transform = CGAffineTransform(translationX: container.frame.width, y: 0)
                toView.transform = .identity
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
