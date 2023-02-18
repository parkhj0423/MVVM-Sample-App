//
//  MainView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some View {
        BottomTabView(viewRouter: viewRouter)
            .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
