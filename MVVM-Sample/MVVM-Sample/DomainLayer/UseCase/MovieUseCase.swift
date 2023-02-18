//
//  MovieUseCase.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public protocol MovieUseCaseInterface {
    func getMovieList(page : Int?) async throws -> MovieListEntity
    func getMovieListByKeyword(keyword : String) async throws -> MovieListEntity
    func getMovieDetail(movieId : Int) async throws -> MovieDetailEntity
}

final class MovieUseCase : MovieUseCaseInterface {
    
    private let repository : MovieRepositoryInterface
    
    public init(repository : MovieRepositoryInterface) {
        self.repository = repository
    }
    
    func getMovieList(page : Int?) async throws -> MovieListEntity {
        guard let page = page else {
            return try await repository.getMovieLists(page: 1)
        }
        
        return try await repository.getMovieLists(page: page)
    }
    
    func getMovieDetail(movieId: Int) async throws -> MovieDetailEntity {
        return try await repository.getMovieDetail(movieId: movieId)
    }
    
    func getMovieListByKeyword(keyword : String) async throws -> MovieListEntity {
        return try await repository.getMovieListByKeyword(keyword: keyword)
    }
    
}
