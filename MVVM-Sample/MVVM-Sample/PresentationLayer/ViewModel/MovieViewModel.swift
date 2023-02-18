//
//  MovieViewModel.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation
import Combine

@MainActor
public final class MovieViewModel : ObservableObject {
    
    private let useCase : MovieUseCaseInterface
    private let userDefaultsUseCase : UserDefaultsUseCaseInterface
    
    @Published public var movieList : [MovieEntity] = []
    @Published public var currentPage : Int = 1
    
    @Published public var movieDetailItem : MovieDetailEntity?
    
    @Published public var bookmarkList : [MovieEntity] = []
    
    @Published public var error : NetworkError? {
        didSet {
            self.isLoading = false
        }
    }
    @Published public var isLoading : Bool = false
    
    public init(useCase : MovieUseCaseInterface, userDefaultsUseCase : UserDefaultsUseCaseInterface) {
        self.useCase = useCase
        self.userDefaultsUseCase = userDefaultsUseCase
        getMovieList()
    }
    
    public func getMovieList(page : Int? = nil) {
        Task {
            self.isLoading = true
            do {
                let movieEntityList = try await useCase.getMovieList(page: page)
                
                appendMovieList(page: page, newMovies: movieEntityList.movies)
                self.currentPage = movieEntityList.pageNumber
            } catch {
                self.error = error as? NetworkError
            }
        }
    }
    
    public func getDetailMovie(movieId : Int) {
        Task {
            self.isLoading = true
            do {
                self.movieDetailItem = try await useCase.getMovieDetail(movieId: movieId)
                self.isLoading = false
            } catch {
                self.error = error as? NetworkError
            }
        }
    }
    
    // Request한 페이지가 0일 경우 현재 movieList를 15(default)개 받아온 것으로 초기화, 0이아닐 경우 기존 리스트 뒤에 Append
    private func appendMovieList(page : Int?, newMovies : [MovieEntity]) {
        self.isLoading = false
        if page == nil {
            return self.movieList = newMovies
        }
        
        return self.movieList.append(contentsOf: newMovies)
    }
    
    // MovieList의 마지막 Item인지 체크
    public func isLastItem(currentItem : MovieEntity) -> Bool {
        guard let lastMovieItem = movieList.last else {
            return false
        }
        return lastMovieItem.id == currentItem.id
    }
    
    public func clearMovieDetailItem() {
        self.movieDetailItem = nil
    }
    
    public func clearError() {
        self.error = nil
    }
    
    public func addBookmark(movie: MovieEntity) {
        self.bookmarkList = userDefaultsUseCase.addBookmark(movie: movie)
    }
    
    public func removeBookmark(movie: MovieEntity) {
        self.bookmarkList = userDefaultsUseCase.removeBookmark(movie: movie)
    }
    
    public func isBookmark(movie: MovieEntity) -> Bool {
        return userDefaultsUseCase.isBookmark(movie: movie)
    }
    
    
}
