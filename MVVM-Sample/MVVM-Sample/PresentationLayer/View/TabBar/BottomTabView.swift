//
//  TabView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct BottomTabView: View {
    
    @ObservedObject var viewRouter : ViewRouter
    
    @State private var selectedItem = 0
    
    init(viewRouter : ViewRouter) {
        self.viewRouter = viewRouter
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing : 0) {
                TabView (selection: $selectedItem){
                    tabBarItem(tag: 0) {
                        MovieListView(viewModel: AppDI.shared.getMovieDependencies())
                    }
                    
                    tabBarItem(tag: 1) {
                        SearchView(viewModel: AppDI.shared.getSearchDependencies())
                    }
                    
                    tabBarItem(tag: 2) {
                        BookmarkView(viewModel: AppDI.shared.getBookmarkDependencies())
                    }  
                }
                
                tabBarButton(geometry: geometry)
            }
        }
    }
    
    
    private func tabBarButton(geometry : GeometryProxy) -> some View {
        HStack {
            TabBarIcon(viewRouter: viewRouter, assingnedView: .home, width: geometry.size.width / 4)
            TabBarIcon(viewRouter: viewRouter, assingnedView: .search, width: geometry.size.width / 4)
            TabBarIcon(viewRouter: viewRouter, assingnedView: .bookmark, width: geometry.size.width / 4)
        }
        .frame(width : geometry.size.width, height: 50)
        .background(tabBarShadow())
        .onReceive(viewRouter.$currentView) { currentView in
            switch currentView {
            case .home:
                selectedItem = 0
            case .search:
                selectedItem = 1
            case .bookmark:
                selectedItem = 2
            }
        }
    }

    private func tabBarShadow() -> some View {
        Color.white
            .offset(y: 1)
            .shadow(color : Color.gray.opacity(0.1), radius : 0, x: 0 , y : -1)
            .ignoresSafeArea()
    }
    
    
    private func tabBarItem<Content: View>(tag : Int, content: () -> Content) -> some View {
        NavigationView {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(viewRouter.getNavigationTitle())
                .navigationBarColor(backgroundColor: UIColor.white, shadowColor: getNavigationShadowColor())
        }
        .tag(tag)
        .tint(Color.black)
    }
    
    private func getNavigationShadowColor() -> UIColor {
        if viewRouter.currentView != .search {
            return UIColor(Color.gray.opacity(0.5))
        }
        return UIColor.white
    }
}
