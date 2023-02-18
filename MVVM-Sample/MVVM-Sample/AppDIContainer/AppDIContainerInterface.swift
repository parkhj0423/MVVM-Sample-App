//
//  AppDIContainerInterface.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public protocol AppDIContainerInterface {
    func getMovieDependencies() -> MovieViewModel
    func getSearchDependencies() -> SearchViewModel
    func getBookmarkDependencies() -> BookmarkViewModel
}
