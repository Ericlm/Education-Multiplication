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
    
    var numberOfAnswers = 4
    var multiplication: Multiplication!
    var scene: AnimalsScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = AnimalsScene(size: animalsView.frame.size)
        animalsView.presentScene(scene)
        
        updateMultiplication()
    }
    
    @objc func buttonPressed(button: AnswerButton) {
        if multiplication.isNumberCorrect(button.numberToDisplay) {
            scene.dropSprite()
        } else {
            button.playWrongAnswerAnimation()
        }
    }
    
    private func updateMultiplication() {
        multiplication = Multiplication(factorsRange: 1...12, numberOfAnswers: numberOfAnswers, numberOfFactors: 2)
        multiplicationLabel.text = multiplication.operationText()
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
