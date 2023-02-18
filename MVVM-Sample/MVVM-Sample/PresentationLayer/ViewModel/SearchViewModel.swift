//
//  SearchViewModel.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation
import Combine

@MainActor
public final class SearchViewModel : ObservableObject {
    
    private let useCase : MovieUseCaseInterface
    private var bag : Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published public var keyword : String = ""
    @Published public var searchedMovieList : [MovieEntity] = []
   
    @Published public var error : NetworkError? {
        didSet {
            self.isLoading = false
        }
    }
    @Published public var isLoading : Bool = false
    
    public init(useCase : MovieUseCaseInterface) {
        self.useCase = useCase
        inputKeyword()
    }
    
    private func inputKeyword() {
        $keyword
            .debounce(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] keyword in
                guard !keyword.isEmpty else {
                    self?.searchedMovieList = []
                    return
                }
                
                // 1.5초 후에 입력된 값이 비어있지 않다면 해당 값으로 검색
                self?.getMovieListByKeyword(keyword: keyword)
                
            })
            .store(in: &bag)
    }
    
    private func getMovieListByKeyword(keyword : String) {
        Task {
            self.isLoading = true
            do {
                self.searchedMovieList = try await self.useCase.getMovieListByKeyword(keyword: keyword).movies
                self.isLoading = false
            } catch NetworkError.decodingError {
                self.isLoading = false
            } catch {
                self.error = error as? NetworkError
            }
        }
    }
  
    public func showEmptyView() -> Bool {
        return self.searchedMovieList.isEmpty && !self.isLoading
    }
    
    public func clearError() {
        self.error = nil
    }
    
    
}
