//
//  MainMenuViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 22/02/2021.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet var rangeSliderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "uncolored_castle")
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        navigationController?.view.insertSubview(imageView, at: 0)
        
        navigationController?.delegate = self
        
        let slider = StepRangeSlider(frame: rangeSliderView.bounds, range: 1...12)
        rangeSliderView.addSubview(slider)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuickGameSegue", let multiplicationViewController = segue.destination as? MultiplicationViewController {
            #warning("The selected factors and factor range are manually set")
            multiplicationViewController.selectedFactors = Array(1...2)
            multiplicationViewController.factorsRange = 1...1
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
            return NavigationAnimator(presenting: true)
        } else {
            return NavigationAnimator(presenting: false)
        }
    }
}
