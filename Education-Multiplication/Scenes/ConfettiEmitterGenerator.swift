//
//  ConfettiEmitterGenerator.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 04/03/2021.
//

import Foundation
import SpriteKit

enum ConfettiColor: String, CaseIterable {
    case lightblue = "confetti-bleu-clair"
    case blue = "confetti-bleu"
    case yellow = "confetti-jaune"
    case orange = "confetti-orange"
    case pink = "confetti-rose"
    case red = "confetti-rouge"
    case lightgreen = "confetti-vert-clair"
    case green = "confetti-vert"
    case purple = "confetti-violet"
}

class ConfettiEmitterGenerator {
     
    static func createRainConfettiEmitter(forConfettiColor color: ConfettiColor, emissionRange: CGVector) -> SKEmitterNode {
        let texture = SKTexture(imageNamed: color.rawValue)
        let emitterNode = SKEmitterNode(fileNamed: "ConfettiRain")!
        emitterNode.particleSize = texture.size()
        emitterNode.particleTexture = texture
        emitterNode.particlePositionRange = emissionRange
        return emitterNode
    }
    
    static func createCanonConfettiEmitter(forConfettiColor color: ConfettiColor) -> SKEmitterNode {
        let texture = SKTexture(imageNamed: color.rawValue)
        let emitterNode = SKEmitterNode(fileNamed: "ConfettiCanon")!
        emitterNode.particleSize = texture.size()
        emitterNode.particleTexture = texture
        return emitterNode
    }
    
    static func createPopConfettiEmitter(forConfettiColor color: ConfettiColor) -> SKEmitterNode {
        let texture = SKTexture(imageNamed: color.rawValue)
        let emitterNode = SKEmitterNode(fileNamed: "ConfettiPop")!
        emitterNode.particleTexture = texture
        emitterNode.particleSize = texture.size()
        return emitterNode
    }
}
