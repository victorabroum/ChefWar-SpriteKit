//
//  AntNode.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 28/02/24.
//

import Foundation
import SpriteKit

class AntNode: SKNode {
    
    var sprite: SKSpriteNode
    
    override init() {
        sprite = .init(imageNamed: "ant_1")
        super.init()
        
        self.addChild(sprite)
        self.name = "ant"
        
        sprite.run(.repeatForever(.animate(with: .init(withFormat: "ant_%@", range: 1...4), timePerFrame: 0.1)))
        
        sprite.anchorPoint.y = 0.3
        
        setupPhysics()
    }
    
    private func setupPhysics() {
        let body = SKPhysicsBody(circleOfRadius: sprite.size.width/4)
        body.affectedByGravity = false
        body.categoryBitMask = 2
        body.collisionBitMask = 0
        self.physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func death() {
        guard let particleExplosion = SKScene(fileNamed: "Explosion") else { return }
        
        self.removeAllActions()
        self.physicsBody = nil
        sprite.removeAllActions()
        sprite.texture = .init(imageNamed: "deadAnt")
        sprite.texture?.filteringMode = .nearest
        
        particleExplosion.setScale(0.4)
        
        self.addChild(particleExplosion)
        self.run(.sequence([
            .wait(forDuration: 0.5),
            .removeFromParent()
        ]))
    }
    
}
