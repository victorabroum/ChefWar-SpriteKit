//
//  ChefNode.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 28/02/24.
//

import Foundation
import SpriteKit

class ChefNode: SKNode {
    
    var sprite: SKSpriteNode
    
    override init() {
        sprite = .init(imageNamed: "player_1")
        super.init()
        
        sprite.texture?.filteringMode = .nearest
        sprite.run(.repeatForever(.animate(with: .init(withFormat: "player_%@", range: 1...4), timePerFrame: 0.1)))
        
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
