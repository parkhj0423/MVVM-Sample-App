//
//  UserDefaultsRepositoryInterface.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation

protocol UserDefaultsRepositoryInterface {
    func getBookmarkList() -> [MovieEntity]
    func addBookmark(movie : MovieEntity) -> [MovieEntity]
    func removeBookmark(movie : MovieEntity) -> [MovieEntity]
    func isBookmark(movie : MovieEntity) -> Bool
}
