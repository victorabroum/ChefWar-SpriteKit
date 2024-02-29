//
//  Comparable+Tools.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 29/02/24.
//

import Foundation

extension Comparable {
    func clamp(_ lower: Self, _ upper: Self) -> Self {
        return min(max(self, lower), upper)
    }
}
