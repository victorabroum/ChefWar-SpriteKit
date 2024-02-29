//
//  DistanceBetweenObjects.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 28/02/24.
//

import Foundation

extension CGPoint {
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
    
    static func randomPosition(in range: ClosedRange<CGFloat>) -> CGPoint {
        return .init(x: .random(in: range), y: .random(in: range))
    }
    
    static func randomPositionByAngle(distance: CGFloat) -> CGPoint {
        let randomAngle = CGFloat.random(in: 0...(2 * CGFloat.pi))
        
        let x = distance * cos(randomAngle)
        let y = distance * sin(randomAngle)
        
        return CGPoint(x: x, y: y)
    }
}
