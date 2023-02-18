//
//  RefreshableScrollView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI
import Foundation

enum RefreshState {
    case ready
    case refreshing
}

public struct RefreshableScrollView<Content: View>: View {
    var action : () -> Void
    var content: Content

    @State private var state: RefreshState = .ready
    @State private var canChangeState = true
    @State private var refreshing = false
    @State private var pullProgress: CGFloat = 0
    @State private var pullOffset: CGFloat = 0

    private let feedbackGenerator = UIImpactFeedbackGenerator()

    public init(action : @escaping () -> (), @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content()
    }

    public var body: some View {
        GeometryReader { proxy in
            let pullThreshold = proxy.size.height * 0.2

            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    content
                        .background(
                            GeometryReader { proxy in
                                let frame = proxy.frame(in: .named("scrollView"))
                                Color.clear.preference(key: OffsetPreferenceKey.self, value: frame.origin)
                            }
                        )
                }
                .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                    canChangeState = canChangeState || offset.y <= 0
                    pullProgress = pullProgress(offset: offset, threshold: pullThreshold)
                    pullOffset = offset.y - pullThreshold

                    if isReady && pullProgress == 1 {
                        refresh()
                    } else {
                        state = .ready
                    }

                    refreshing = !isReady
                }

                PullToRefresh(progress: pullProgress, refreshing: refreshing)
                    .frame(height: pullThreshold)
                    .offset(y: pullOffset)
            }
            .coordinateSpace(name: "scrollView")
        }
    }
    
    private var isReady: Bool {
        return state == .ready && canChangeState
    }
    
    private func pullProgress(offset: CGPoint, threshold: CGFloat) -> CGFloat {
        let progress = offset.y / threshold
        return progress.bounded(bottom: 0, top: 1)
    }

    private func refresh() {
        feedbackGenerator.impactOccurred()
        state = .refreshing
        canChangeState = false

        action()
    }
}

public struct PullToRefresh: View {
    private let progress: CGFloat
    private let refreshing: Bool

    public init(progress: CGFloat, refreshing: Bool) {
        self.progress = progress
        self.refreshing = refreshing
    }

    public var body: some View {
        VStack(spacing: 8) {
            if refreshing {
                ProgressView()
            }
        }
        .foregroundColor(Color(.systemGray))
        .opacity(progress)
    }
}
