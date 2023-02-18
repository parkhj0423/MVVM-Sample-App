//
//  MovieItemView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct MovieItemView: View {
    
    @ObservedObject var viewModel : MovieViewModel
    var movieItem : MovieEntity
    
    @State private var showMoreDescription : Bool = false
    @State private var isBookmark : Bool = false
    @State private var doubleTapAnimation : Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            profileView()
            
            AsyncImageLoader(imageUrl : movieItem.largeCoverImage)
                .doubleTapAnimationViewHandler(isBookmark : isBookmark, doubleTapAnimaion: $doubleTapAnimation) {
                    bookmarkAction()
                }
            
            buttonArea()
            
            GenreView(genres: movieItem.genres)
            
            descriptionView()
            
        }
        .onAppear {
            // 가지고 있는 MovieList의 마지막 Item을 만날경우 currentPage에 1을 더하여 새로운 리스트를 호출하여 기존 리스트에 Append
            // 부모뷰에서 LazyVStack으로 가지고 있기 때문에 매 Item이 Appear할때마다 체크
            if viewModel.isLastItem(currentItem: movieItem) {
                viewModel.getMovieList(page: viewModel.currentPage + 1)
            }
        }
        .onAppear {
            self.isBookmark = viewModel.isBookmark(movie: movieItem)
        }
        .padding(.vertical)
    }
    
    //ProfileView
    
    private func profileView() -> some View {
        HStack(alignment : .top, spacing: 10) {
            AsyncImageLoader(imageUrl: movieItem.smallCoverImage, width: 30, height: 30, radius: 50)
            
            titleView()
        }
        .padding(.horizontal, 10)
    }
    
    private func titleView() -> some View {
        VStack(alignment : .leading, spacing : 3) {
            Text(movieItem.title ?? "제목 없음")
                .font(.system(size: 15, weight: .bold))
            
            subTitleView()
        }
    }
    
    private func subTitleView() -> some View {
        HStack(alignment : .top, spacing : 1) {
            Text(movieItem.titleLong ?? "")
            
            Text("﹒")
            
            Text(movieItem.imdbCode ?? "")
        }
        .font(.system(size: 11))
        .foregroundColor(Color.gray)
    }
    
    //buttonArea
    
    private func buttonArea() -> some View {
        HStack(spacing : 15) {
            Button {
                bookmarkAction()
            } label: {
                Image(systemName: viewModel.isBookmark(movie: movieItem) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.pink)
            }
            
            Spacer()
            
            detailLinkView()
        }
        .padding(.horizontal, 10)
    }
    
    private func detailLinkView() -> some View {
        NavigationLink {
            MovieDetailView(viewModel: viewModel, movieItem: movieItem)
        } label: {
            Image(systemName: "chevron.right.2")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(Color.black)
        }
    }
    
    //DescriptionView
    
    private func descriptionView() -> some View {
        HStack(alignment : .top, spacing : 10) {
            
            VStack(alignment : .leading, spacing: 4) {
                Text(movieItem.descriptionFull ?? "")
                    .font(.system(size: 12, weight: .medium))
                // 로컬변수 showMoreDescription가 false일 경우 description의 linelimit을 1로줘 1줄 이후의 내용은 ... 으로 대체
                // more 버튼을 통해 showMoreDescription을 토글할 경우 나머지 description이 보임
                    .lineLimit(showMoreDescription ? nil : 1)
                    .foregroundColor(Color.black)
                
                Text("Uploaded : \(movieItem.date_uploaded ?? "")")
                    .font(.system(size: 10))
                    .foregroundColor(Color.gray)
            }
            
            
            if !showMoreDescription {
                showMoreButton()
            }
        }
        .padding(.horizontal, 10)
    }
    
    private func showMoreButton() -> some View {
        Button {
            self.showMoreDescription = true
        } label: {
            Text("more")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(Color.gray.opacity(0.5))
        }
    }
    
    private func bookmarkAction() {
        if viewModel.isBookmark(movie: movieItem) {
            viewModel.removeBookmark(movie: movieItem)
            self.isBookmark = false
        } else {
            viewModel.addBookmark(movie: movieItem)
            self.isBookmark = true
        }
    }
}
