//
//  GameScene+ContactDelegate.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 29/02/24.
//

import Foundation
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else { return }
        
        handleContactCleaver_Ant(nodeA: nodeA, nodeB: nodeB)
        handleContactCleaver_Ant(nodeA: nodeB, nodeB: nodeA)
    }
    
    private func handleContactCleaver_Ant(nodeA: SKNode, nodeB: SKNode) {
        if nodeA is CleaverNode, let antNode = nodeB as? AntNode {
            SoundController.shared.playSoundFX(named: "Hit.wav")
            scoreController.addScore()
            
            nodeA.removeFromParent()
            
            antNode.death()
        }
    }
    
}
