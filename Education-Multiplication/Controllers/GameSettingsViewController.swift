//
//  GameSettingsViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 22/02/2021.
//

import UIKit
import SpriteKit

class GameSettingsViewController: UIViewController {
    @IBOutlet var tableCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // We set the background transparent so that the navigation's image is visible.
        view.backgroundColor = .clear
        
        tableCollection.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // We set the controller as delegate to handle animations to the game controller.
        navigationController?.delegate = self
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
            return CGSize(width: 70, height: 70)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}

extension GameSettingsViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC is AdvancedSettingsViewController {
            return HorizontalSlideNavigationAnimator(presenting: true)
        } else if toVC is MainMenuViewController {
            return HorizontalSlideNavigationAnimator(presenting: false)
        }
        
        // Show the game view controller
        if operation == .push {
            return VerticalSlideNavigationAnimator(presenting: true)
        } else {
            return VerticalSlideNavigationAnimator(presenting: false)
        }
    }
}
