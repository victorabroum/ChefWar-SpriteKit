//
//  Actions+Custom.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 29/02/24.
//

import Foundation
import SpriteKit

extension SKAction {
    static func shake(duration: CGFloat, amplitudeX: CGFloat = 12, amplitudeY: CGFloat = 6) -> SKAction {
        let numberOfShakes = Int(duration / 0.04 / 2) // 0.04 segundos por frame (1/25)
        var actionsArray: [SKAction] = []
        
        for _ in 0..<numberOfShakes {
            let moveX = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2
            let moveY = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2
            let shakeAction = SKAction.moveBy(x: moveX, y: moveY, duration: 0.02)
            shakeAction.timingMode = .easeOut
            actionsArray.append(shakeAction)
            actionsArray.append(shakeAction.reversed())
        }
        
        return SKAction.sequence(actionsArray)
    }
}
