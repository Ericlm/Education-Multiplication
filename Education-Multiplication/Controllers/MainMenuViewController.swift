//
//  MainMenuViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 22/02/2021.
//

import UIKit

class MainMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "uncolored_castle")
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        navigationController?.view.insertSubview(imageView, at: 0)
        
        navigationController?.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
