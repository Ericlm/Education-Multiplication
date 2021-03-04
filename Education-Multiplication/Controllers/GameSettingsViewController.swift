//
//  GameSettingsViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 22/02/2021.
//

import UIKit
import SpriteKit

class GameSettingsViewController: UIViewController {
    @IBOutlet var rangeSliderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // We set the background transparent so that the navigation's image is visible.
        view.backgroundColor = .clear
        
        // We set the controller as delegate to handle animations to the game controller.
        navigationController?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        let slider = StepRangeSlider(frame: rangeSliderView.bounds, range: 1...12)
        slider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
        rangeSliderView.addSubview(slider)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MultiplicationSegue", let multiplicationViewController = segue.destination as? MultiplicationViewController {
            #warning("The selected factors and factor range are manually set")
            multiplicationViewController.factorsRange = 1...20
            multiplicationViewController.selectedFactors = [1]
            multiplicationViewController.numberOfAnswers = 4
            multiplicationViewController.numberOfFactors = 2
        }
    }
    
    @objc func rangeSliderValueChanged(_ slider: StepRangeSlider) {
        #warning("Range slider values changed does nothing")
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
