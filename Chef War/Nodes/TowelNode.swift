//
//  TowelNode.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 29/02/24.
//

import Foundation
import SpriteKit

class TowelNode: SKNode {
    
    var towelNode: SKSpriteNode
    var foodsNode: SKSpriteNode
    
    override init() {
        towelNode = .init(imageNamed: "towel")
        foodsNode = .init(imageNamed: "foods")
        super.init()
        
        self.addChild(towelNode)
        towelNode.addChild(foodsNode)
        
        towelNode.zPosition = -10
        foodsNode.zPosition = 1
        
        towelNode.texture?.filteringMode = .nearest
        foodsNode.texture?.filteringMode = .nearest
        
        foodsNode.position.y = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
