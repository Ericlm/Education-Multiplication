//
//  MultiplicationViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 20/02/2021.
//

import UIKit
import SpriteKit

class MultiplicationViewController: UIViewController {
    @IBOutlet var animalsView: SKView!
    @IBOutlet var multiplicationLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    /// Time for fade-in and fade-out animations for buttons and label.
    let animationTime = 0.4
    
    /// The factors the user selected to be questionned abou.t
    var selectedFactors: [Int]!
    /// The range of the factors the multiplication can be generated with.
    var factorsRange: ClosedRange<Int>!
    /// The number of factors used to generate the multiplication.
    var numberOfFactors: Int!
    /// The number of answers that are available to the user.
    var numberOfAnswers: Int!
    
    /// The current running multiplication
    var multiplication: Multiplication!
    /// The SKScene used to add fun to the exercise.
    var scene: AnimalsScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We create the scene with the size of the SKView and present it
        scene = AnimalsScene(size: animalsView.frame.size)
        animalsView.presentScene(scene)
        
        //We generate a multiplication and assign its question to the label
        multiplication = Multiplication(factorsRange: factorsRange, selectedFactors: selectedFactors, numberOfAnswers: numberOfAnswers, numberOfFactors: numberOfFactors)
        multiplicationLabel.text = multiplication.operationText()
    }
    
    /// Called when the user press a button representing an answer. Depending on the number displayed by the button, it validates or invalidates the answer.
    /// If the answer is correct, it also takes care of updating the multiplication.
    /// - Parameter button: The `AnswerButton` the user pressed.
    @objc func buttonPressed(button: AnswerButton) {
        if multiplication.isNumberCorrect(button.numberToDisplay) {
            scene.dropSprite()
            updateMultiplication()
        } else {
            button.playWrongAnswerAnimation()
        }
    }
    
    /// Updates the current multiplication by re-generating it, then animates the label and updates it to have the new multiplication's values. It also aks the button to reload their value.
    private func updateMultiplication() {
        multiplication = Multiplication(factorsRange: factorsRange, selectedFactors: selectedFactors, numberOfAnswers: numberOfAnswers, numberOfFactors: numberOfFactors)
        
        //Multiplication label fade-out and fade-in
        UIView.animate(withDuration: animationTime) { [unowned self] in
            multiplicationLabel.alpha = 0.0
        } completion: { [unowned self] _ in
            multiplicationLabel.text = multiplication.operationText()
            
            UIView.animate(withDuration: animationTime) { [unowned self] in
                multiplicationLabel.alpha = 1.0
            }
        }

        //We get the cells of the collectionView and access their AnswerButton to update their value, and then ask them to reload.
        for answerCell in collectionView.visibleCells {
            if let button = answerCell.contentView.viewWithTag(1) as? AnswerButton {
                let indexPath = collectionView.indexPath(for: answerCell)!
                button.numberToDisplay = multiplication.possibleAnswers[indexPath.row]
                button.reload(animationTime: animationTime)
            }
        }
    }
}

extension MultiplicationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfAnswers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCell", for: indexPath)
        if let button = cell.contentView.viewWithTag(1) as? AnswerButton {
            button.numberToDisplay = multiplication.possibleAnswers[indexPath.row]
            button.setTitle(String(button.numberToDisplay), for: .normal)
            button.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
        }
        return cell
    }
}

extension MultiplicationViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    /// The vertical spacing needed between the cells.
    var verticalSpacing: CGFloat {
        traitCollection.horizontalSizeClass == .compact ? 20 : 20
    }
    /// The horizontal inset (left and right) to apply to the collectionView layout.
    var horizontalInset: CGFloat {
        traitCollection.horizontalSizeClass == .compact ? 20 : 80
    }
    /// The height of the cells
    var cellHeight: CGFloat {
        traitCollection.horizontalSizeClass == .compact ? 80 : 120
    }
    /// The cell width relative to the collectionView width. This value will be multiplied by the width of the collectionView.
    var cellWidthMultiplier: CGFloat {
        traitCollection.horizontalSizeClass == .compact ? 0.4 : 0.35
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width * cellWidthMultiplier
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return verticalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //We want the cells to be always vertically center aligned.
        
        //Figure out the number of lines based on the number of answers. We cast to Double to avoid truncating, then round it up.
        let numberOfLines = Int((Double(numberOfAnswers) / 2.0).rounded(.up))
        //The total height of cell's lines.
        let cellsHeight = CGFloat(numberOfLines) * self.cellHeight
        //The height of all lines including their vertical spacing
        let totalHeight = cellsHeight + verticalSpacing * CGFloat((numberOfLines - 1))
        //The vertical inset is then the collectionView height minus the cellsHeight, divided by two for top and bottom
        let verticalInsets = (collectionView.frame.size.height - totalHeight) / 2
        
        let insets = UIEdgeInsets(top: verticalInsets, left: horizontalInset, bottom: verticalInsets, right: horizontalInset)
        return insets
    }
}
