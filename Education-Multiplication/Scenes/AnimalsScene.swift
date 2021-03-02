//
//  AnimalsScene.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import SpriteKit

class AnimalsScene: SKScene {
    private var background: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        let shape = SKShapeNode(circleOfRadius: 20)
        shape.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(shape)
        
        addBackground()
    }
    
    func dropSprite() {
        print("Drop sprite")
    }
    
    private func addBackground() {
        background = SKSpriteNode(imageNamed: "background_desert")
        background.blendMode = .replace
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(background)
    }
}
