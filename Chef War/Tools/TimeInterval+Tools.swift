//
//  TimeInterval+Tools.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 05/03/24.
//

import Foundation

extension TimeInterval {
    internal static func calculateTravelTime(speed: CGFloat, distance: CGFloat) -> TimeInterval {        
        return distance / speed
    }
}
