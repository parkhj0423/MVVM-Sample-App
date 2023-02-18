//
//  MovieEntity.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public struct MovieEntity : Codable, Identifiable {
    public let id : Int
    let url : String?
    let imdbCode : String?
    let title : String?
    let titleEnglish : String?
    let titleLong : String?
    let slug : String?
    let year : Int?
    let rating : Double?
    let runtime : Int?
    let genres : [String]?
    let summary : String?
    let descriptionFull : String?
    let synopsis : String?
    let ytTrailerCode : String?
    let language : String?
    let mpa_rating : String?
    let backgroundImage : String?
    let backgroundImageOriginal : String?
    let smallCoverImage : String?
    let mediumCoverImage : String?
    let largeCoverImage : String?
    let date_uploaded : String?
}
