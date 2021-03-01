//
//  GameSettingsViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 22/02/2021.
//

import UIKit

class GameSettingsViewController: UIViewController {
    @IBOutlet var rangeSliderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        let slider = StepRangeSlider(frame: rangeSliderView.bounds, range: 1...12)
        rangeSliderView.addSubview(slider)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MultiplicationSegue", let multiplicationViewController = segue.destination as? MultiplicationViewController {
            #warning("The selected factors and factor range are manually set")
            multiplicationViewController.factorsRange = 1...20
            multiplicationViewController.selectedFactors = Array(1...2)
            multiplicationViewController.numberOfAnswers = 4
            multiplicationViewController.numberOfFactors = 2
        }
    }
}

extension GameSettingsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return FadeColorNavigationAnimator(isPresenting: true)
        } else {
            return FadeColorNavigationAnimator(isPresenting: false)
        }
    }
}
