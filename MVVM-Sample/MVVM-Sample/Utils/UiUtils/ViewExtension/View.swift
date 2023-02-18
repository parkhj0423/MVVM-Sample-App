//
//  View.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation
import SwiftUI

extension View {
    func navigationBarColor(backgroundColor: UIColor?, shadowColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, shadowColor: shadowColor))
    }
    
    func loadingViewHandler(isLoading: Bool) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
    
    func errorViewHandler(error : NetworkError?, refresh : @escaping () -> Void) -> some View {
        self.modifier(ErrorViewModifier(error: error, refresh : refresh))
    }
    
    func doubleTapAnimationViewHandler(isBookmark : Bool, doubleTapAnimaion : Binding<Bool>, action : @escaping () -> Void) -> some View {
        self.modifier(DoubleTapAnimationViewModifier(isBookmark : isBookmark, doubleTapAnimation: doubleTapAnimaion, action : action))
    }
    
}
