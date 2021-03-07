//
//  AnimalsScene.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 21/02/2021.
//

import SpriteKit

class AnimalsScene: SKScene {
    private let animalsSpriteName = ["bear","buffalo","chick","chicken","cow","crocodile","dog","duck","elephant","frog","giraffe","goat","gorilla","hippo","horse","monkey","moose","narwhal","owl","panda","parrot","penguin","pig","rabbit","rhino","sloth","snake","walrus","whale","zebra"]
    
    var maximumNumberOfSprites: Int!
    private var background: SKSpriteNode!
    private var animalSize: CGSize {
        let screenArea = size.width * size.height
        let spriteArea = screenArea / CGFloat(maximumNumberOfSprites)
        let spriteSize = sqrt(spriteArea) * 0.95
        return CGSize(width: spriteSize, height: spriteSize)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width, height: size.height*2))
        
        addBackground()
    }
    
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
    
    private func addBackground() {
        background = SKSpriteNode(imageNamed: "background_house")
        background.zPosition = -1
        background.blendMode = .replace
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let backgroundAspectRatio = size.height / background.size.height
        background.setScale(backgroundAspectRatio)
        addChild(background)
    }
    
    func createRandomConfettis() {
        let confettiMethods = [createCanonConfetti, createPopConfettis, createRainConfettis]
        confettiMethods.randomElement()!()
    }
    
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
    
    private func createPopConfettis() {
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
    
    private func createRainConfettis() {
        for color in ConfettiColor.allCases {
            let emitterNode = ConfettiEmitterGenerator.createRainConfettiEmitter(forConfettiColor: color, emissionRange: CGVector(dx: size.width, dy: 0))
            emitterNode.position = CGPoint(x: size.width/2, y: size.height + 20)
            addChild(emitterNode)
        }
    }
}

extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}
