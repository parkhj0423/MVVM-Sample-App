//
//  SearchView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel : SearchViewModel
    
    var body: some View {
        VStack {
            if viewModel.showEmptyView() {
                emptyView()
            } else {
                searchedMovieListView()
            }
        }
        .errorViewHandler(error: viewModel.error) {
            viewModel.clearError()
        }
        .loadingViewHandler(isLoading: viewModel.isLoading)
        .searchable(text: $viewModel.keyword, placement: .automatic)
    }
    
    private func searchedMovieListView() -> some View {
        ScrollView {
            LazyVStack(alignment : .leading) {
                ForEach(viewModel.searchedMovieList) { movieItem in
                    searchedMovieItem(movieItem: movieItem)
                }
            }
            .padding()
        }
    }
    
    private func searchedMovieItem(movieItem : MovieEntity) -> some View {
        NavigationLink(destination: MovieDetailView(viewModel: AppDI.shared.getMovieDependencies(), movieItem: movieItem)) {
            HStack {
                MovieInfoRow(movieItem: movieItem)
                
                chevronButton()
            }
        }
    }
    
    @ViewBuilder
    private func chevronButton() -> some View {
        Spacer(minLength: 0)
        Image(systemName: "chevron.right")
    }
    
    private func emptyView() -> some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 25, height: 25)
            
            Text("Search By Keyword")
            Text("(Title, Actor, Director name...)")
        }
        .font(.system(size: 12, weight: .bold))
        .foregroundColor(Color.gray)
    }
    
    
}
