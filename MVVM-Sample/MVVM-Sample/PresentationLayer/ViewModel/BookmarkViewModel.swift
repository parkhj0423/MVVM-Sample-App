//
//  BookmarkViewModel.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation
import Combine

@MainActor
public final class BookmarkViewModel : ObservableObject {
    
    private let useCase : UserDefaultsUseCaseInterface
    private var bag : Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var bookmarkList : [MovieEntity] = []
        
    public init(useCase : UserDefaultsUseCaseInterface) {
        self.useCase = useCase
    }
    
    public func showEmptyView() -> Bool {
        return self.bookmarkList.isEmpty
    }
    
    public func getBookmarkList() {
        self.bookmarkList = useCase.getBookmarkList()
    }
    
    public func addBookmark(movie: MovieEntity) {
        self.bookmarkList = useCase.addBookmark(movie: movie)
    }
    
    public func removeBookmark(movie: MovieEntity) {
        self.bookmarkList = useCase.removeBookmark(movie: movie)
    }
    
    public func isBookmark(movie: MovieEntity) -> Bool {
       return useCase.isBookmark(movie: movie)
    }
    
    public func isFirstItem(currentItem : MovieEntity) -> Bool {
        guard let lastBookmarkItem = bookmarkList.first else {
            return false
        }
        return lastBookmarkItem.id == currentItem.id
    }
    
}
