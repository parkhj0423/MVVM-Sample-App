//
//  ContentView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel : MovieViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            RefreshableScrollView {
                viewModel.getMovieList()
            } content: {
                movieListView()
            }
        }
        .loadingViewHandler(isLoading: viewModel.isLoading)
        .errorViewHandler(error: viewModel.error) {
            viewModel.clearError()
            viewModel.getMovieList()
        }
    }
    
    private func movieListView() -> some View {
        LazyVStack {
            ForEach(viewModel.movieList) { movieItem in
                MovieItemView(viewModel: viewModel, movieItem: movieItem)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: AppDI.shared.getMovieDependencies())
    }
}
