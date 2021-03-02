//
//  AnimalsScene.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import UIKit
import SpriteKit

class AnimalsScene: SKScene {
    private var background: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 213/255, green: 238/255, blue: 250/255, alpha: 1)
        addBackground()
    }
    
    func dropSprite() {
        print("Drop sprite")
    }
    
    private func addBackground() {
        background = SKSpriteNode(imageNamed: "background_desert")
        background.blendMode = .replace
        background.position = CGPoint(x: size.width/2, y: -size.height/2)
        addChild(background)
    }
    
    func showBackground() {
        let action = SKAction.moveBy(x: 0, y: size.height, duration: 2.0)
        action.timingMode = .easeInEaseOut
        background.run(action)
    }
}
