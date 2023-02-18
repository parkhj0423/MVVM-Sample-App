//
//  UserDefaultsRepository.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation

final class UserDefaultsRepository : UserDefaultsRepositoryInterface {
    private let userDefaultsStorage : UserDefaultsStorage = UserDefaultsStorage()
    
    func getBookmarkList() -> [MovieEntity] {
        return userDefaultsStorage.getBookmarkList()
    }
    
    func addBookmark(movie: MovieEntity) -> [MovieEntity] {
        userDefaultsStorage.addBookmark(movie: movie)
        
        return userDefaultsStorage.getBookmarkList()
    }
    
    func removeBookmark(movie: MovieEntity) -> [MovieEntity] {
        userDefaultsStorage.removeBookmark(movie: movie)
        
        return userDefaultsStorage.getBookmarkList()
    }
    
    func isBookmark(movie: MovieEntity) -> Bool {
        return userDefaultsStorage.isBookmark(movie: movie)
    }
}
