//
//  MovieDetailEntity.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public struct MovieDetailEntity : Encodable, Identifiable {
    public let id : Int
    let url : String?
    let imdbCode : String?
    let title : String?
    let titleLong : String?
    let slug : String?
    let year : Int?
    let rating : Double?
    let runtime : Int?
    let genres : [String]?
    let summary : String?
    let downloadCount : Int?
    let likeCount : Int?
    let descriptionIntro : String?
    let descriptionFull : String?
    let synopsis : String?
    let language : String?
    let backgroundImage : String?
    let backgroundImageOriginal : String?
    let smallCoverImage : String?
    let mediumCoverImage : String?
    let largeCoverImage : String?
    let date_uploaded : String?
    
    
    func getStarRating() -> Int {
        guard let rating = rating else {
            return 0
        }
        return Int(round(rating))
    }
}
