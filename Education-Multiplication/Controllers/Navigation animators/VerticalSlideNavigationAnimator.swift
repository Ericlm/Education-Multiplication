//
//  FadeColorNavigationAnimator.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import UIKit
import SpriteKit

class VerticalSlideNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    /// Indicates if the navigation asks for a push or pop animation.
    private let presenting: Bool
    
    /// Initialize the navigation animator with a way to navigate (push or pop).
    /// - Parameter presenting: Does the navigation is presenting a new view controller, or does it go back to a previously visited view controller?
    init(presenting: Bool) {
        self.presenting = presenting
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
            // If we're presenting, we offset the target view by the current view height, so it's at the bottom of the screen.
            toView.transform = CGAffineTransform(translationX: 0, y: container.frame.height)
            container.addSubview(toView)
        } else {
            container.addSubview(toView)
            // We need to reset the target view's transform
            toView.transform.tx = 0
            // We manually set the frame so that "CGAffineTransform.identity" is correct
            toView.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
            toView.transform = CGAffineTransform(translationX: 0, y: -container.frame.height)
            
            // We going back to the main menu, we also need to add the CloudScene back to the navigation controller
            let scene = CloudScene(size: toView.frame.size)
            let skView = SKView(frame: CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height))
            skView.transform = CGAffineTransform(translationX: 0, y: -container.frame.height)
            skView.allowsTransparency = true
            skView.tag = 1
            skView.presentScene(scene)
            transitionContext.viewController(forKey: .to)?.navigationController?.view.insertSubview(skView, at: 0)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
            if self.presenting {
                if let skView = transitionContext.viewController(forKey: .from)?.navigationController?.view.viewWithTag(1) as? SKView {
                    skView.transform = CGAffineTransform(translationX: 0, y: -container.frame.height)
                }
                
                toView.transform = .identity
                fromView.transform = CGAffineTransform(translationX: 0, y: -container.frame.height)
            } else {
                if let skView = transitionContext.viewController(forKey: .from)?.navigationController?.view.viewWithTag(1) as? SKView {
                    skView.transform = .identity
                }
                
                fromView.transform = CGAffineTransform(translationX: 0, y: container.frame.height)
                toView.transform = .identity
            }
        } completion: { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            
            // When the transition completes, and that we're now showing the MultiplicationViewController, we need to remove the SKView.
            if transitionContext.viewController(forKey: .to) is MultiplicationViewController {
                if let gameSettingsViewController = transitionContext.viewController(forKey: .from) as? GameSettingsViewController, let skView = gameSettingsViewController.navigationController?.view.viewWithTag(1) as? SKView {
                    skView.removeFromSuperview()
                }
            }
            
            transitionContext.completeTransition(success)
        }
    }
}
