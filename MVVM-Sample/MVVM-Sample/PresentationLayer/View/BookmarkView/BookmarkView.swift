//
//  BookmarkView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct BookmarkView: View {
    
    @StateObject var viewModel : BookmarkViewModel
    
    var body: some View {
        VStack {
            if viewModel.showEmptyView() {
                emptyView()
            } else {
                bookmarkListView()
            }
        }
        .padding([.horizontal])
        .onAppear {
            viewModel.getBookmarkList()
        }
    }
    
    private func bookmarkListView() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment : .leading) {
                ForEach(viewModel.bookmarkList) { bookmarkItem in
                    VStack(alignment : .leading) {
                        bookmarkItemView(bookmarkItem : bookmarkItem)
                    }
                    .padding(.top, viewModel.isFirstItem(currentItem: bookmarkItem) ? 20 : 0)
                }
            }
        }
    }
    
    private func bookmarkItemView(bookmarkItem : MovieEntity) -> some View {
        HStack(alignment : .top) {
            MovieInfoRow(movieItem: bookmarkItem)
            
            bookmarkRemoveButton(bookmarkItem: bookmarkItem)
        }
    }
    
    @ViewBuilder
    private func bookmarkRemoveButton(bookmarkItem : MovieEntity) -> some View {
        Spacer(minLength: 0)
        Button {
            viewModel.removeBookmark(movie: bookmarkItem)
        } label : {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.pink)
        }
    }
    
    
    private func emptyView() -> some View {
        VStack {
            Image(systemName: "archivebox")
                .resizable()
                .frame(width: 25, height: 25)
            
            Text("No Bookmarks..")
            Text("Try Adding Bookmarks")
        }
        .font(.system(size: 12, weight: .bold))
        .foregroundColor(Color.gray)        
    }
}
