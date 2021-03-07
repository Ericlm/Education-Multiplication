//
//  SlideNavigationAnimator.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 23/02/2021.
//

import UIKit

class HorizontalSlideNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    /// Indicates if the navigation asks for a push or pop animation.
    private let presenting: Bool
    
    /// Initialize the navigation animator with a way to navigate (push or pop).
    /// - Parameter presenting: Does the navigation is presenting a new view controller, or does it go back to a previously visited view controller?
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
            // Offset the target view by the current view width, so it's at the right of the screen
            toView.transform = CGAffineTransform(translationX: container.frame.width, y: 0)
            container.addSubview(toView)
        } else {
            // To be able to move the target view using "CGAffineTransform.identity", we need to manually set the frame.
            toView.frame = CGRect(x: -container.frame.width, y: 0, width: container.frame.width, height: container.frame.height)
            toView.transform = CGAffineTransform(translationX: -container.frame.width, y: 0)
            container.addSubview(toView)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseInOut]) {
            if self.presenting {
                // If we're presenting, we slide the two views to the left
                toView.transform = .identity
                fromView.transform = CGAffineTransform(translationX: -container.frame.width, y: 0)
            } else {
                // If we're not presenting, we slide the two views to the right
                fromView.transform = CGAffineTransform(translationX: container.frame.width, y: 0)
                toView.transform = .identity
            }
        } completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            // If the transition failed, we immediately remove the target view.
            if !success {
                toView.removeFromSuperview()
            }
            
            transitionContext.completeTransition(success)
        }
    }
}
