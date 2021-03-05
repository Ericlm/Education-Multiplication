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
    @IBOutlet var tableCollection: UICollectionView!
    
    private var stepSlider: StepRangeSlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // We set the background transparent so that the navigation's image is visible.
        view.backgroundColor = .clear
        
        // We set the controller as delegate to handle animations to the game controller.
        navigationController?.delegate = self
        
        tableCollection.allowsMultipleSelection = true
    }
    
    override func viewDidLayoutSubviews() {
        guard stepSlider == nil else { return }
        stepSlider = StepRangeSlider(frame: rangeSliderView.bounds, range: 1...12)
        stepSlider!.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
        rangeSliderView.addSubview(stepSlider!)
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

extension GameSettingsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tableCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SelectTableCollectionViewCell
        cell.text = String(indexPath.row + 1)
        return cell
    }
}

extension GameSettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if traitCollection.horizontalSizeClass == .compact {
            return CGSize(width: 50, height: 50)
        } else {
            return CGSize(width: 100, height: 100)
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
