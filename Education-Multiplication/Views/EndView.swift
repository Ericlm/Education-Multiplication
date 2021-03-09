//
//  EndView.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 08/03/2021.
//

import UIKit

protocol EndViewDelegate: UIViewController {
    func mainMenuButtonTapped()
    func replayButtonTapped()
}

@IBDesignable
class EndView: UIView {
    @IBOutlet var scoreLabel: UILabel!
    
    weak var delegate: EndViewDelegate?
    
    var maximumScore: Int = 0
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)/\(maximumScore)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// A common initializer to be used in `init(frame:)` and `init(coder:)`.
    private func commonInit() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.layer.cornerRadius = 20
        addSubview(view)
    }
    
    /// Load the *StepperView* from a Xib file and returns it.
    /// - Returns: The view loaded from the nib file.
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: EndView.self)
        let nib = UINib(nibName: "EndView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func show(_ show: Bool = true) {
        if show {
            alpha = 0.0
            isHidden = false
        }
        
        UIView.animate(withDuration: 1) { [unowned self] in
            alpha = show ? 1.0 : 0.0
        } completion: { [unowned self] (success) in
            if !show {
                isHidden = true
            }
        }
    }
    
    @IBAction func backToMainMenu(_ sender: BigButton) {
        delegate?.mainMenuButtonTapped()
    }
    
    @IBAction func playAgain(_ sender: BigButton) {
        delegate?.replayButtonTapped()
    }
}
