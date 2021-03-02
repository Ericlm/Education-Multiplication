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
        
        // We add the scene to the navigation controller.
        let scene = CloudScene(size: view.frame.size)
        let sceneView = SKView(frame: view.frame)
        sceneView.presentScene(scene)
        navigationController?.view.insertSubview(sceneView, at: 0)
        
        // We set this controller to be the delegate to handle the animations when pushing/poping controllers.
        navigationController?.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the user selected a quick game, we push a MultiplicationViewController with template values.
        if segue.identifier == "QuickGameSegue", let multiplicationViewController = segue.destination as? MultiplicationViewController {
            multiplicationViewController.selectedFactors = Preferences.selectedFactors
            multiplicationViewController.factorsRange = Preferences.factorsRange
            multiplicationViewController.numberOfAnswers = 4
            multiplicationViewController.numberOfFactors = 2
        } else if segue.identifier == "SettingsSegue" {
            //view.isHidden = true
        }
    }
}

extension MainMenuViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return SlideNavigationAnimator(presenting: true)
        } else {
            return SlideNavigationAnimator(presenting: false)
        }
    }
}
