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
    
    private let numberOfCells = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // We set the background transparent so that the navigation's image is visible.
        view.backgroundColor = .clear
        
        // We allow multiple selection so that the user can select multiple tables.
        tableCollection.allowsMultipleSelection = true
        
        let selectedTables = Preferences.selectedFactors
        for index in 0..<numberOfCells where selectedTables.contains(index + 1) {
            let indexPath = IndexPath(item: index, section: 0)
            tableCollection.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
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
        
        // Going to the AdvancedSettingsViewController or going back to the MainMenuViewController
        if toVC is AdvancedSettingsViewController {
            return HorizontalSlideNavigationAnimator(presenting: true)
        } else if toVC is MainMenuViewController {
            return HorizontalSlideNavigationAnimator(presenting: false)
        }
        
        // Show the game view controller
        return VerticalSlideNavigationAnimator(presenting: true)
    }
}
