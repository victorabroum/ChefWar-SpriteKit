//
//  CleaverNode.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 28/02/24.
//

import Foundation
import SpriteKit

class CleaverNode: SKNode {
    
    var sprite: SKSpriteNode
    
    override init() {
        sprite = .init(imageNamed: "cleaver")
        super.init()
        
        self.addChild(sprite)
        self.name = "cleaver"
        sprite.texture?.filteringMode = .nearest
        
        self.run(.sequence([
            .wait(forDuration: 0.1),
            .run(setupPhysics)
        ]))
        
    }
    
    private func setupPhysics() {
        let body = SKPhysicsBody(rectangleOf: sprite.size)
        body.affectedByGravity = false
        body.categoryBitMask = 1
        body.collisionBitMask = 0
        body.contactTestBitMask = 2
        self.physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func spiked() {
//        SoundController.shared.playSoundFX(named: "Picked.wav")
        physicsBody = nil
        sprite.texture = .init(imageNamed: "cleaver_spiked")
        sprite.texture?.filteringMode = .nearest
        self.zRotation = 0
    }
}
