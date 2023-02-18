//
//  Comparable.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public extension Comparable {
    func bounded(bottom lowerBound: Self, top upperBound: Self) -> Self {
        var value = max(lowerBound, self)
        value = min(upperBound, self)
        return value
    }
}
