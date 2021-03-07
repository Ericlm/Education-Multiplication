//
//  FadeColorNavigationAnimator.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 01/03/2021.
//

import UIKit
import SpriteKit

class VerticalSlideNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let presenting: Bool
    
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
            toView.transform = CGAffineTransform(translationX: 0, y: container.frame.height)
            container.addSubview(toView)
        } else {
            container.addSubview(toView)
            toView.transform.tx = 0
            toView.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: container.frame.height)
            toView.transform = CGAffineTransform(translationX: 0, y: -container.frame.height)
            
            let scene = CloudScene(size: toView.frame.size)
            let skView = SKView(frame: CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height))
            skView.transform = CGAffineTransform(translationX: 0, y: -container.frame.height)
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
            
            if transitionContext.viewController(forKey: .to) is MultiplicationViewController {
                if let gameSettingsViewController = transitionContext.viewController(forKey: .from) as? GameSettingsViewController, let skView = gameSettingsViewController.navigationController?.view.viewWithTag(1) as? SKView {
                    skView.removeFromSuperview()
                }
            }
            
            transitionContext.completeTransition(success)
        }
    }
}
