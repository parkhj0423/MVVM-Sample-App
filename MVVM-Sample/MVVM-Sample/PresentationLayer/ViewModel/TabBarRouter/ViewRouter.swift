//
//  ViewRouter.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public enum TabPage {
    case home
    case search
    case bookmark
}

final class ViewRouter : ObservableObject {
    @Published public var currentView : TabPage = .home
    
    public func changeTab(_ to : TabPage) {
        self.currentView = to
    }
    
    public func getSystemImageName(assignedView : TabPage) -> String {
        switch assignedView {
        case .home :
            return "house.fill"
        case .search :
            return "magnifyingglass"
        case .bookmark :
            return "heart.fill"
        }
    }
    
    public func getNavigationTitle() -> String {
        switch currentView {
        case .home :
            return "Movie List"
        case .search :
            return "Search Movies"
        case .bookmark :
            return "Bookmark List"
        }
    }
    
    public func isCurrentTab(assignedView : TabPage) -> Bool {
        return currentView == assignedView
    }
}
