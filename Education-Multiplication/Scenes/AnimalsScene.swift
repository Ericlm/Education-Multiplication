//
//  AnimalsScene.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import SpriteKit

class AnimalsScene: SKScene {
    /// Names of every animals sprites.
    private let animalsSpriteName = ["bear","buffalo","chick","chicken","cow","crocodile","dog","duck","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale","zebra"]
    
    /// The maximum number of sprites that can appear on the scene.
    var maximumNumberOfSprites: Int!
    /// The background image.
    private var background: SKSpriteNode!
    /// Size of the sprite for the animals.
    private var animalSize: CGSize {
        let screenArea = size.width * size.height
        let spriteArea = screenArea / CGFloat(maximumNumberOfSprites)
        let spriteSize = sqrt(spriteArea) * 0.95
        return CGSize(width: spriteSize, height: spriteSize)
    }
    
    override func didMove(to view: SKView) {
        // Create a rectangular physics body around the scene
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width, height: size.height*2))
        
        addBackground()
    }
    
    /// Create a given number of animal sprites in the scene. They are dropped from the top of the scene.
    /// - Parameter numberToDrop: The number of sprites to drop.
    func dropSprites(_ numberToDrop: Int) {
        for _ in 0..<numberToDrop {
            let animal = SKSpriteNode(imageNamed: animalsSpriteName.randomElement()!)
            animal.size = animalSize
            animal.physicsBody = SKPhysicsBody(circleOfRadius: animal.size.width/2)
            animal.position = CGPoint(x: CGFloat.random(in: animal.size.width/2...size.width-animal.size.width/2), y: size.height + animal.size.height/2)
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval.random(in: 0...1.2)) { [weak self] in
                self?.addChild(animal)
            }
        }
    }
    
    /// Adds a background to the scene.
    private func addBackground() {
        background = SKSpriteNode(imageNamed: "background_house")
        background.zPosition = -1
        background.blendMode = .replace
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let backgroundAspectRatio = size.height / background.size.height
        background.setScale(backgroundAspectRatio)
        addChild(background)
    }
    
    /// Creates a confetti effect, choose randomly from a variety of emitters.
    /// The current emitters are:
    /// * CanonConfetti: An effect where confettis are pushed from the bottom of the screen to the top, and then fall down.
    /// * PopConfetti: An effect that looks like fireworks, but with confettis.
    /// * RainConfetti: An effect where confettis slowly fall from the top on the screen, and fill up the entire screen.
    func createRandomConfettis() {
        let confettiMethods = [createCanonConfetti, createPopConfettis, createRainConfettis]
        confettiMethods.randomElement()!()
    }
    
    /// Creates an emitter node where confettis appears from the bottom of the screen, are propulsed to the top, and then fall back.
    private func createCanonConfetti() {
        let colors = ConfettiColor.allCases
        for (index,color) in colors.enumerated() {
            let emitterNode = ConfettiEmitterGenerator.createCanonConfettiEmitter(forConfettiColor: color)
            
            let xOffset = size.width / CGFloat(colors.count) / 2
            let xPosition: CGFloat = size.width * CGFloat(index) / CGFloat(colors.count) + xOffset
            let position = CGPoint(x: xPosition, y: 0)
            emitterNode.position = position
            addChild(emitterNode)
        }
    }
    
    /// Creates an emitter node that looks like fireworks: confettis of various color appears at random position, and then seems to explode.
    private func createPopConfettis() {
        let createConfettisAction = SKAction.run { [unowned self] in
            for color in ConfettiColor.allCases {
                let emitterNode = ConfettiEmitterGenerator.createPopConfettiEmitter(forConfettiColor: color)
                let randomPosition = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
                emitterNode.position = randomPosition
                emitterNode.isPaused = true
                addChild(emitterNode)
                
                let randomTime = TimeInterval.random(in: 0...1)
                DispatchQueue.main.asyncAfter(deadline: .now() + randomTime) {
                    emitterNode.isPaused = false
                }
            }
        }
        let waitAction = SKAction.wait(forDuration: 1.5, withRange: 0.5)
        let repeatPopConfettisAction = SKAction.repeatForever(SKAction.sequence([createConfettisAction, waitAction]))
        run(repeatPopConfettisAction)
    }
    
    /// Creates an emitter node looking like a confetti's rain. They are generated from the top of the screen on the entire width, and then fall down slowly.
    private func createRainConfettis() {
        for color in ConfettiColor.allCases {
            let emitterNode = ConfettiEmitterGenerator.createRainConfettiEmitter(forConfettiColor: color, emissionRange: CGVector(dx: size.width, dy: 0))
            emitterNode.position = CGPoint(x: size.width/2, y: size.height + 20)
            addChild(emitterNode)
        }
    }
}
