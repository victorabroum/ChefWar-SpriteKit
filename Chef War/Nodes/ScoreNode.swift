//
//  ScoreNode.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 29/02/24.
//

import Foundation
import SpriteKit

class ScoreNode: SKNode {
    
    var scoreAmountLabel: SKLabelNode
    var scoreLabel: SKLabelNode
    
    override init() {
        scoreLabel = SKLabelNode(text: "Score:")
        scoreAmountLabel = SKLabelNode(text: "0")
        super.init()
        
        self.addChild(scoreLabel)
        self.addChild(scoreAmountLabel)
        
        scoreLabel.horizontalAlignmentMode = .right
        scoreAmountLabel.horizontalAlignmentMode = .left
        scoreAmountLabel.position.x += 5
        
        scoreLabel.fontName = "Downhill Dive DEMO"
        scoreAmountLabel.fontName = scoreLabel.fontName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateScore(value: String) {
        scoreAmountLabel.text = value
    }
}
