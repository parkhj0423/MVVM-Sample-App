//
//  MovieResponseDTO.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public struct MovieResponseDTO : Decodable {
    let status : String
    let status_message : String
    let data : MovieDataResponseDTO
    
    func toEntity() -> MovieListEntity {
        var movieEntityList : [MovieEntity] = []
        data.movies.forEach { movieDTO in
            movieEntityList.append(
                MovieEntity(
                    id: movieDTO.id,
                    url: movieDTO.url,
                    imdbCode: movieDTO.imdb_code,
                    title: movieDTO.title,
                    titleEnglish: movieDTO.title_english,
                    titleLong: movieDTO.title_long,
                    slug: movieDTO.slug,
                    year: movieDTO.year,
                    rating: movieDTO.rating,
                    runtime: movieDTO.runtime,
                    genres: movieDTO.genres,
                    summary: movieDTO.summary,
                    descriptionFull: movieDTO.description_full,
                    synopsis: movieDTO.synopsis,
                    ytTrailerCode: movieDTO.yt_trailer_code,
                    language: movieDTO.language,
                    mpa_rating: movieDTO.mpa_rating,
                    backgroundImage: movieDTO.background_image,
                    backgroundImageOriginal: movieDTO.background_image_original,
                    smallCoverImage: movieDTO.small_cover_image,
                    mediumCoverImage: movieDTO.medium_cover_image,
                    largeCoverImage: movieDTO.large_cover_image,
                    date_uploaded: movieDTO.date_uploaded
                )
            )
        }

        return MovieListEntity(limitCount: data.limit, pageNumber: data.page_number, movies: movieEntityList)
    }
}

public struct MovieDataResponseDTO : Decodable {
    let movie_count : Int?
    let limit : Int
    let page_number : Int
    let movies : [MovieDTO]
}
