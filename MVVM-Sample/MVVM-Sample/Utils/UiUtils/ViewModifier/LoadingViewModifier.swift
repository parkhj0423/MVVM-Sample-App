//
//  LoadingViewModifier.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation
import SwiftUI

struct LoadingViewModifier: ViewModifier {
    
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoading {
                VStack(spacing : 10) {
                    ProgressView()
                    Text("Loading...")
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color.primary)
                .opacity(isLoading ? 1 : 0)
                
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
