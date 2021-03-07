//
//  CloudScene.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 02/03/2021.
//

import SpriteKit

class CloudScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 213/255, green: 238/255, blue: 250/255, alpha: 1)
        
        // Creates and start 8 particle emitters (one per texture)
        for i in 1...8 {
            let texture = SKTexture(imageNamed: "cloud\(i)")
            let emitter = SKEmitterNode(fileNamed: "Clouds")!
            emitter.particleBirthRate = CGFloat.random(in: 0.05...0.1)
            emitter.particleTexture = texture
            emitter.particlePositionRange = CGVector(dx: 0, dy: size.height)
            emitter.position = CGPoint(x: size.width + 200, y: size.height/2 + texture.size().height/2)
            emitter.advanceSimulationTime(30)
            addChild(emitter)
        }
    }
}
