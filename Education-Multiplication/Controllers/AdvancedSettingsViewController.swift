//
//  AdvancedSettingsViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 05/03/2021.
//

import UIKit
import SpriteKit

class AdvancedSettingsViewController: UIViewController {
    @IBOutlet var rangeSliderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        let stepSlider = StepRangeSlider(frame: rangeSliderView.bounds, range: 1...12)
        stepSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
        rangeSliderView.addSubview(stepSlider)
    }
    
    @objc func rangeSliderValueChanged(_ slider: StepRangeSlider) {
        #warning("Range slider values changed does nothing")
        print("Lower slider : \(slider.lowerValue)")
        print("Upper slider : \(slider.upperValue)")
    }
}

extension AdvancedSettingsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HorizontalSlideNavigationAnimator(presenting: false)
    }
}
