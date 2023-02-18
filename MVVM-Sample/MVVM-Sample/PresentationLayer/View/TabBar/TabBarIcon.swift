//
//  TabBarIcon.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct TabBarIcon: View {
    @ObservedObject var viewRouter : ViewRouter
    let assingnedView : TabPage
    
    let width : CGFloat
    
    var body: some View {
        VStack(spacing : 3) {
            currentTabIcon()
            
            if viewRouter.isCurrentTab(assignedView: assingnedView) {
                currentTabIndicator()
            }
        }
    }
    
    private func currentTabIcon() -> some View {
        Button {
            viewRouter.changeTab(assingnedView)
        } label: {
            Image(systemName: viewRouter.getSystemImageName(assignedView: assingnedView))
                .frame(width: width, height: 30)
                .foregroundColor(Color.black)
        }
    }
    
    private func currentTabIndicator() -> some View {
        Circle()
            .fill(Color.red)
            .frame(width: 5, height: 5)
    }
    
}
