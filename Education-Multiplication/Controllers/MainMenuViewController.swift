//
//  MainMenuViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 22/02/2021.
//

import UIKit
import SpriteKit

class MainMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // We set the background to be transparent, so the navigationController's image can be displayed.
        view.backgroundColor = .clear
        
        // We set the navigation controller's view background color, so that the entire app has the same background.
        navigationController?.view.backgroundColor = UIColor(red: 213/255, green: 238/255, blue: 250/255, alpha: 1)
        
        addSKView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // We set this controller to be the delegate to handle the animations when pushing/poping controllers.
        navigationController?.delegate = self
    }
    
    /// Adds an SKView showing the CloudScene to the navigation controller.
    func addSKView() {
        let scene = CloudScene(size: view.frame.size)
        let skView = SKView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        skView.isAsynchronous = false
        skView.allowsTransparency = true
        skView.tag = 1
        skView.presentScene(scene)
        navigationController?.view.insertSubview(skView, at: 0)
    }
}

extension MainMenuViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return HorizontalSlideNavigationAnimator(presenting: true)
        } else {
            return HorizontalSlideNavigationAnimator(presenting: false)
        }
    }
}
