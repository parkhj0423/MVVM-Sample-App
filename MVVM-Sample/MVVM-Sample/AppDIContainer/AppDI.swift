//
//  AppDI.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public class AppDI : AppDIContainerInterface {
    static let shared = AppDI()
    
    @MainActor public func getMovieDependencies() -> MovieViewModel {
        let movieDataSource : MovieDataSourceInterface = MovieDataSource()
        let movieRepository : MovieRepositoryInterface = MovieRepository(dataSource: movieDataSource)
        let movieUseCase : MovieUseCaseInterface = MovieUseCase(repository: movieRepository)
        
        let userDefaultsRepository : UserDefaultsRepositoryInterface = UserDefaultsRepository()
        let userDefaultsUseCase : UserDefaultsUseCaseInterface = UserDefaultsUseCase(repository: userDefaultsRepository)
        
        return MovieViewModel(useCase: movieUseCase, userDefaultsUseCase : userDefaultsUseCase)
    }
    
    @MainActor public func getSearchDependencies() -> SearchViewModel {
        let movieDataSource : MovieDataSourceInterface = MovieDataSource()
        let movieRepository : MovieRepositoryInterface = MovieRepository(dataSource: movieDataSource)
        let movieUseCase : MovieUseCaseInterface = MovieUseCase(repository: movieRepository)
        
        return SearchViewModel(useCase: movieUseCase)
    }
    
    @MainActor public func getBookmarkDependencies() -> BookmarkViewModel {
        let userDefaultsRepository : UserDefaultsRepositoryInterface = UserDefaultsRepository()
        let userDefaultsUseCase : UserDefaultsUseCaseInterface = UserDefaultsUseCase(repository: userDefaultsRepository)
        
        return BookmarkViewModel(useCase: userDefaultsUseCase)
    }
}
