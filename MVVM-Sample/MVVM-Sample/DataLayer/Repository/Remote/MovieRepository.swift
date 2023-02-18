//
//  MovieRepository.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

final class MovieRepository : MovieRepositoryInterface {
    
    private let dataSource : MovieDataSourceInterface
    
    public init(dataSource : MovieDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    
    func getMovieLists(page : Int) async throws -> MovieListEntity {
        return try await dataSource.getMovieLists(page: page).toEntity()
    }
    
    func getMovieDetail(movieId: Int) async throws -> MovieDetailEntity {
        return try await dataSource.getMovieDetail(movieId: movieId).toEntity()
    }
    
    func getMovieListByKeyword(keyword : String) async throws -> MovieListEntity {
        return try await dataSource.getMovieListByKeyword(keyword: keyword).toEntity()
    }
    
}
