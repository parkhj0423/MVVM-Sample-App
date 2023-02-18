//
//  MovieDataSource.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

protocol MovieDataSourceInterface {
    func getMovieLists(page : Int) async throws -> MovieResponseDTO
    func getMovieDetail(movieId : Int) async throws -> MovieDetailResponseDTO
    func getMovieListByKeyword(keyword : String) async throws -> MovieResponseDTO
}


final class MovieDataSource : NetworkUtil, MovieDataSourceInterface {
    
    func getMovieLists(page : Int) async throws -> MovieResponseDTO {
        let url : String = "list_movies.json"
        
        let parameters : [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(15)")
        ]
        
        return try await sendRequest(url: url, method: .GET, parameters : parameters)
    }
    
    func getMovieDetail(movieId: Int) async throws -> MovieDetailResponseDTO {
        let url : String = "movie_details.json"
        
        let parameters : [URLQueryItem] = [
            URLQueryItem(name: "movie_id", value: "\(movieId)")
        ]
        
        return try await sendRequest(url: url, method: .GET, parameters : parameters)
    }
    
    func getMovieListByKeyword(keyword : String) async throws -> MovieResponseDTO {
        let url : String = "list_movies.json"
        
        let parameters : [URLQueryItem] = [
            URLQueryItem(name: "query_term", value: keyword)
        ]
        
        return try await sendRequest(url: url, method: .GET, parameters : parameters)
    }
    
    
}
