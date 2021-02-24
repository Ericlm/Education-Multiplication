//
//  GameSettingsViewController.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 22/02/2021.
//

import UIKit

class GameSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MultiplicationSegue", let multiplicationViewController = segue.destination as? MultiplicationViewController {
            #warning("The selected factors and factor range are manually set")
            multiplicationViewController.factorsRange = 1...20
            multiplicationViewController.selectedFactors = Array(1...2)
            multiplicationViewController.numberOfAnswers = 4
            multiplicationViewController.numberOfFactors = 2
        }
    }
}
