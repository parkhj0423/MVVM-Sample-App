//
//  UserDefaultsStorage.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation

enum UserDefaultCase : String {
    case bookmark = "bookmark"
}

class UserDefaultsStorage : NSObject {
    @UserDefaultWrapper(key : UserDefaultCase.bookmark.rawValue, defaultValue : []) static var bookmarkList : [MovieEntity]
    
    func getBookmarkList() -> [MovieEntity] {
        return UserDefaultsStorage.bookmarkList
    }
    
    func addBookmark(movie : MovieEntity) {
        UserDefaultsStorage.bookmarkList.append(movie)
    }
    
    func removeBookmark(movie : MovieEntity) {
        let filteredBookmarkList = UserDefaultsStorage.bookmarkList.filter({ bookmarkItem in
            return movie.id != bookmarkItem.id
        })
        
        UserDefaultsStorage.bookmarkList = filteredBookmarkList
    }
    
    func isBookmark(movie : MovieEntity) -> Bool {
        let isContain = UserDefaultsStorage.bookmarkList.contains(where: { bookmarkItem in
            return movie.id == bookmarkItem.id
        })

        if isContain {
            return true
        }

        return false
    }
    
}
