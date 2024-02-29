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
        
        setupPhysics()
    }
    
    private func setupPhysics() {
        let body = SKPhysicsBody(rectangleOf: sprite.size)
        body.affectedByGravity = false
        body.categoryBitMask = 2
        body.collisionBitMask = 0
        self.physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
