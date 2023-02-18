//
//  DoubleTapAnimationViewModifier.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation
import SwiftUI

struct DoubleTapAnimationViewModifier: ViewModifier {
    
    var isBookmark : Bool
    @Binding var doubleTapAnimation : Bool
    var action : () -> Void
    
    func body(content: Content) -> some View {
        content
            .onTapGesture(count: 2) {
                if !isBookmark {
                    withAnimation {
                        self.doubleTapAnimation = true
                    }
                    
                    action()
                }
            }
            .overlay(
                ZStack {
                    if doubleTapAnimation {
                        Color.gray.opacity(0.6)
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.pink)
                    }
                }
            )
            .onChange(of: doubleTapAnimation) {
                if $0 {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                        withAnimation {
                            doubleTapAnimation = false
                        }
                    }
                }
            }
    }
}
