//
//  MovieDetailResponseDTO.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public struct MovieDetailResponseDTO : Decodable {
    let status : String
    let status_message : String
    let data : MovieDetailDataResponseDTO
    let meta : MetaDTO?
    
    func toEntity() -> MovieDetailEntity {
        return  MovieDetailEntity(
            id: data.movie.id,
            url: data.movie.url,
            imdbCode: data.movie.imdb_code,
            title: data.movie.title,
            titleLong: data.movie.title_long,
            slug: data.movie.slug,
            year: data.movie.year,
            rating: data.movie.rating,
            runtime: data.movie.runtime,
            genres: data.movie.genres,
            summary: data.movie.summary,
            downloadCount: data.movie.download_count,
            likeCount: data.movie.like_count,
            descriptionIntro: data.movie.description_intro,
            descriptionFull: data.movie.description_full,
            synopsis: data.movie.synopsis,
            language: data.movie.language,
            backgroundImage: data.movie.background_image,
            backgroundImageOriginal: data.movie.background_image_original,
            smallCoverImage: data.movie.small_cover_image,
            mediumCoverImage: data.movie.medium_cover_image,
            largeCoverImage: data.movie.large_cover_image,
            date_uploaded: data.movie.date_uploaded
        )
    }
}

public struct MovieDetailDataResponseDTO : Decodable {
    let movie : MovieDTO
}


public struct MetaDTO : Decodable {
    let server_time : Int?
    let server_timezone : String?
    let api_version : Int?
    let execution_time : String?
}
