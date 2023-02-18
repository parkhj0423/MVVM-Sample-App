//
//  MovieDetailView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject var viewModel : MovieViewModel
    var movieItem : MovieEntity
    
    var body: some View {
        VStack(alignment : .center) {
            ScrollView(showsIndicators: false) {
                movieCoverWithBackgroundView()
                
                GenreView(genres: viewModel.movieDetailItem?.genres, fontSize: 10)
                
                detailInfoView()
            }
        }
        .toolbar {
            ToolbarItem(placement : .navigationBarLeading) {
                BackButton()
            }
        }
        .navigationTitle(movieItem.titleLong ?? "")
        .navigationBarBackButtonHidden(true)
        .loadingViewHandler(isLoading: viewModel.isLoading)
        .onAppear {
            viewModel.getDetailMovie(movieId: movieItem.id)
        }
        .onDisappear {
            viewModel.clearMovieDetailItem()
        }
    }
    
    private func movieCoverWithBackgroundView() -> some View {
        ZStack(alignment: .top) {
            AsyncImageLoader(imageUrl: viewModel.movieDetailItem?.backgroundImage)
                .blur(radius: 3)
            
            AsyncImageLoader(imageUrl: viewModel.movieDetailItem?.mediumCoverImage, width: 250, height: 450, radius: 20)
                .padding(.top, 80)
        }
    }
    
    private func detailInfoView() -> some View {
        VStack(spacing : 10) {
            if let movieDetailItem = viewModel.movieDetailItem {
                
                VStack(spacing : 3) {
                    Text(movieDetailItem.title ?? "")
                        .font(.system(size: 25, weight: .bold))
                    
                    HStack(alignment : .top) {
                        Text(movieDetailItem.titleLong ?? "")
                        Text("/")
                        Text("\(movieDetailItem.runtime ?? 0) Mins")
                    }
                    .font(.system(size: 17, weight: .medium))
                }
                .foregroundColor(Color.black)
                
                userEvaluationView()
                
                Text(movieDetailItem.descriptionFull ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    private func userEvaluationView() -> some View {
        VStack(spacing : 10) {
            if let movieDetailItem = viewModel.movieDetailItem {
                ratingView(movieDetailItem : movieDetailItem)
                
                HStack {
                    Text("\(movieDetailItem.downloadCount ?? 0) Downloads")
                    Text("\(movieDetailItem.likeCount ?? 0) Likes")
                }
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color.pink)
            }
        }
        .padding(.horizontal)
    }
    
    private func ratingView(movieDetailItem : MovieDetailEntity) -> some View {
        HStack(spacing : 10) {
            ForEach(0..<movieDetailItem.getStarRating() , id : \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 20, height: 20)
            }
        }
    }
}

