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
    @IBOutlet var numberOfQuestionsStepper: StepperView!
    @IBOutlet var numberOfAnswersStepper: StepperView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // We set the background transparent so that we see the clouds scene.
        view.backgroundColor = .clear
        
        numberOfQuestionsStepper.currentValue = Preferences.numberOfQuestions
        numberOfQuestionsStepper.step = 5
        numberOfQuestionsStepper.range = 5...100
        numberOfQuestionsStepper.addTarget(self, action: #selector(numberOfQuestionsValueChanged(_:)), for: .valueChanged)
        
        numberOfAnswersStepper.currentValue = Preferences.numberOfAnswers
        numberOfAnswersStepper.step = 2
        numberOfAnswersStepper.range = 2...8
        numberOfAnswersStepper.addTarget(self, action: #selector(numberOfAnswersValueChanged(_:)), for: .valueChanged)
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
    
    @objc func numberOfQuestionsValueChanged(_ stepper: StepperView) {
        #warning("Questions stepper changes do nothing")
        print(stepper.currentValue)
    }
    
    @objc func numberOfAnswersValueChanged(_ stepper: StepperView) {
        #warning("Answers stepper changes do nothing")
        print(stepper.currentValue)
    }
}

extension AdvancedSettingsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HorizontalSlideNavigationAnimator(presenting: false)
    }
}
