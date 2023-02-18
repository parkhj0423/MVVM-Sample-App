//
//  MovieRepositoryInterface.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public protocol MovieRepositoryInterface {
    func getMovieLists(page : Int) async throws -> MovieListEntity
    func getMovieListByKeyword(keyword : String) async throws -> MovieListEntity
    func getMovieDetail(movieId : Int) async throws -> MovieDetailEntity
}
