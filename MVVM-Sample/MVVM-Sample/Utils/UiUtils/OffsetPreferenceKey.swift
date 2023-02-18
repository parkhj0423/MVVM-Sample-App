//
//  OffsetPreferenceKey.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation
import SwiftUI

public struct OffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGPoint = .zero

    public static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        let newValue = nextValue()
        value.x += newValue.x
        value.y += newValue.y
    }
}
