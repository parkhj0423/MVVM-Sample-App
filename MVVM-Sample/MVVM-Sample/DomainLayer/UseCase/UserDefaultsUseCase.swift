//
//  UserDefaultsUseCase.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation

public protocol UserDefaultsUseCaseInterface {
    func getBookmarkList() -> [MovieEntity]
    func addBookmark(movie : MovieEntity) -> [MovieEntity]
    func removeBookmark(movie : MovieEntity) -> [MovieEntity]
    func isBookmark(movie : MovieEntity) -> Bool
}


final class UserDefaultsUseCase : UserDefaultsUseCaseInterface {
    
    private let repository : UserDefaultsRepositoryInterface
    
    public init(repository : UserDefaultsRepositoryInterface) {
        self.repository = repository
    }
    
    func getBookmarkList() -> [MovieEntity] {
        return repository.getBookmarkList()
    }
    
    func addBookmark(movie: MovieEntity) -> [MovieEntity] {
        return repository.addBookmark(movie: movie)
    }
    
    func removeBookmark(movie: MovieEntity) -> [MovieEntity] {
        return repository.removeBookmark(movie: movie)
    }
    
    func isBookmark(movie: MovieEntity) -> Bool {
        return repository.isBookmark(movie: movie)
    }
}
