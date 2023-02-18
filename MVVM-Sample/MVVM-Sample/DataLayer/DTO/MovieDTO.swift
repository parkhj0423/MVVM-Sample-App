//
//  MovieDTO.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public struct MovieDTO : Decodable {
    let id : Int
    let url : String?
    let imdb_code : String?
    let title : String?
    let title_english : String?
    let title_long : String?
    let slug : String?
    let year : Int?
    let rating : Double?
    let runtime : Int?
    let genres : [String]?
    let download_count : Int?
    let like_count : Int?
    let description_intro : String?
    let summary : String?
    let description_full : String?
    let synopsis : String?
    let yt_trailer_code : String?
    let language : String?
    let mpa_rating : String?
    let background_image : String?
    let background_image_original : String?
    let small_cover_image : String?
    let medium_cover_image : String?
    let large_cover_image : String?
    let state : String?
    let torrents : [TorrentDTO]?
    let date_uploaded : String?
    let date_uploaded_unix : Int?
    
}

public struct TorrentDTO : Decodable {
    let url : String?
    let hash : String?
    let quality : String?
    let type : String?
    let seeds : Int?
    let peers : Int?
    let size : String?
    let size_bytes : Int?
    let date_uploaded : String?
    let date_uploaded_unix : Int?
}
