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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = AnimalsScene(size: animalsView.frame.size)
        animalsView.presentScene(scene)
    }
    
    @objc func buttonPressed(button: AnswerButton) {
        button.playWrongAnswerAnimation()
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfAnswers / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCell", for: indexPath)
        cell.contentView.layer.cornerRadius = 20
        if let button = cell.contentView.viewWithTag(1) as? AnswerButton {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        if section == 0 {
            #warning("Abritrary inset, ideal for 4 buttons.")
            insets.top = 200
        }
        return insets
    }
}
