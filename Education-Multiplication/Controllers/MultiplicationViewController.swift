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
    @IBOutlet var questionNumberLabel: BackgroundLabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var endView: EndView!
    
    /// Time for fade-in and fade-out animations for buttons and label.
    private let animationTime = 0.4
    
    /// The factors the user selected to be questionned about.
    private var selectedFactors: [Int] {
        return Preferences.selectedFactors
    }
    /// The range of the factors the multiplication can be generated with.
    private var factorsRange: ClosedRange<Int> {
        return Preferences.factorsRange
    }
    /// The number of factors used to generate the multiplication.
    private var numberOfFactors: Int {
        return Preferences.numberOfFactors
    }
    /// The number of answers that are available to the user.
    private var numberOfAnswers: Int {
        return Preferences.numberOfAnswers
    }
    /// The number of questions to be asked within the session
    private var numberOfQuestions: Int {
        return Preferences.numberOfQuestions
    }
    /// The maximum possible score.
    private var maximumScore: Int {
        return numberOfQuestions * numberOfAnswers
    }
    
    /// The current running multiplication
    private var multiplication: Multiplication!
    /// The current number of question
    private var currentQuestionNumber = 1 {
        didSet {
            questionNumberLabel.text = "Question \(currentQuestionNumber)/\(numberOfQuestions)"
        }
    }
    /// The number of wrong answers given before the correct one has been submitted.
    private var currentQuestionNumberOfWrongAnswer = 0
    /// The current score of the exercise.
    private var currentScore = 0
    /// The SKScene used to add fun to the exercise.
    private var animalsScene: AnimalsScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        endView.delegate = self
        
        // We create the AnimalsScene and add it to the view.
        animalsView.isAsynchronous = false
        animalsScene = AnimalsScene(size: view.frame.size)
        animalsScene.maximumNumberOfSprites = numberOfQuestions * numberOfAnswers
        animalsView.presentScene(animalsScene)
        
        //We generate a multiplication and assign its question to the label
        multiplication = Multiplication(factorsRange: factorsRange, selectedFactors: selectedFactors, numberOfAnswers: numberOfAnswers, numberOfFactors: numberOfFactors)
        multiplicationLabel.text = multiplication.operationText()
        
        questionNumberLabel.text = "Question \(currentQuestionNumber)/\(numberOfQuestions)"
        endView.maximumScore = maximumScore
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
    }
    
    /// Called when the user press a button representing an answer. Depending on the number displayed by the button, it validates or invalidates the answer.
    /// If the answer is correct, it also takes care of updating the multiplication.
    /// - Parameter button: The `AnswerButton` the user pressed.
    @objc func buttonPressed(button: AnswerButton) {
        if multiplication.isNumberCorrect(button.numberToDisplay) {
            let currentQuestionScore = numberOfAnswers - currentQuestionNumberOfWrongAnswer
            currentScore += currentQuestionScore
            animalsScene.dropSprites(currentQuestionScore)
            
            if currentQuestionNumber == numberOfQuestions {
                hideInterface()
            } else {
                currentQuestionNumber += 1
                currentQuestionNumberOfWrongAnswer = 0
                updateMultiplication()
            }
        } else {
            currentQuestionNumberOfWrongAnswer += 1
            button.playWrongAnswerAnimation()
        }
    }
    
    private func showEndScreen() {
        if currentScore == maximumScore {
            animalsScene.createRandomConfettis()
        }
        endView.score = currentScore
        endView.show()
    }
    
    private func hideInterface() {
        showMultiplicationInterface(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [unowned self] in
            showEndScreen()
        }
    }
    
    private func showMultiplicationInterface(_ show: Bool = true) {
        if show {
            multiplicationLabel.alpha = 0
            multiplicationLabel.isHidden = false
            questionNumberLabel.isHidden = false
            for answerButton in collectionView.visibleCells where answerButton.viewWithTag(1) is AnswerButton {
                answerButton.isHidden = false
            }
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: []) { [unowned self] in
            multiplicationLabel.alpha = show ? 1.0 : 0
            questionNumberLabel.alpha = show ? 1.0 : 0
            for answerButton in collectionView.visibleCells where answerButton.viewWithTag(1) is AnswerButton {
                answerButton.alpha = show ? 1.0 : 0
            }
        } completion: { [unowned self] (finish) in
            if !show {
                multiplicationLabel.isHidden = true
                questionNumberLabel.isHidden = true
                for answerButton in collectionView.visibleCells where answerButton.viewWithTag(1) is AnswerButton {
                    answerButton.isHidden = true
                }
            }
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

extension MultiplicationViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return VerticalSlideNavigationAnimator(presenting: false)
    }
}

extension MultiplicationViewController: EndViewDelegate {
    func mainMenuButtonTapped() {
        animalsScene.resetScene()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func replayButtonTapped() {
        endView.show(false)
        animalsScene.resetScene()
        
        currentQuestionNumber = 1
        currentQuestionNumberOfWrongAnswer = 0
        currentScore = 0
        updateMultiplication()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [unowned self] in
            showMultiplicationInterface()
        }
    }
}
