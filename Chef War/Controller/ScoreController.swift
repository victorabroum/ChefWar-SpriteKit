//
//  ScoreController.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 29/02/24.
//

import Foundation

class ScoreController {
    
    var scoreNode: ScoreNode
    var currentScore: Int = 0
    
    init(scoreNode: ScoreNode) {
        self.scoreNode = scoreNode
    }
    
    public func addScore(amount: Int = 1) {
        currentScore += amount
        scoreNode.updateScore(value: "\(currentScore)")
    }
    
    public func reset() {
        currentScore = 0
        scoreNode.updateScore(value: "\(currentScore)")
    }
}
