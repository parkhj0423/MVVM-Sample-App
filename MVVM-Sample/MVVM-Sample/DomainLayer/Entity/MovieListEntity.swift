//
//  MovieListEntity.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public struct MovieListEntity : Encodable {
    let limitCount : Int
    let pageNumber : Int
    let movies : [MovieEntity]
}
