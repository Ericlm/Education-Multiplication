//
//  ViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 20/02/2021.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet var animalsView: SKView!
    @IBOutlet var multiplicationLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    let animationTime = 0.4
    
    let factorsRange = 1...12
    let numberOfAnswers = 4
    let numberOfFactors = 2
    
    var multiplication: Multiplication!
    var scene: AnimalsScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = AnimalsScene(size: animalsView.frame.size)
        animalsView.presentScene(scene)
        
        multiplication = Multiplication(factorsRange: factorsRange, numberOfAnswers: numberOfAnswers, numberOfFactors: numberOfFactors)
        multiplicationLabel.text = multiplication.operationText()
    }
    
    @objc func buttonPressed(button: AnswerButton) {
        if multiplication.isNumberCorrect(button.numberToDisplay) {
            scene.dropSprite()
            updateMultiplication()
        } else {
            button.playWrongAnswerAnimation()
        }
    }
    
    private func updateMultiplication() {
        multiplication = Multiplication(factorsRange: factorsRange, numberOfAnswers: numberOfAnswers, numberOfFactors: numberOfFactors)
        
        UIView.animate(withDuration: animationTime) { [unowned self] in
            multiplicationLabel.alpha = 0.0
        } completion: { [unowned self] _ in
            multiplicationLabel.text = multiplication.operationText()
            UIView.animate(withDuration: animationTime) { [unowned self] in
                multiplicationLabel.alpha = 1.0
            } completion: { _ in
            }
        }

        for (index,answerCell) in collectionView.visibleCells.enumerated() {
            if let button = answerCell.contentView.viewWithTag(1) as? AnswerButton {
                button.numberToDisplay = multiplication.possibleAnswers[index]
                button.reload(animationTime: animationTime)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfAnswers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCell", for: indexPath)
        cell.contentView.layer.cornerRadius = 20
        if let button = cell.contentView.viewWithTag(1) as? AnswerButton {
            button.numberToDisplay = multiplication.possibleAnswers[indexPath.row]
            button.setTitle(String(button.numberToDisplay), for: .normal)
            button.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width / 2.5
        return CGSize(width: cellWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
        return insets
    }
}
