//
//  MovieInfoRow.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import Foundation
import SwiftUI

struct MovieInfoRow : View {
    var movieItem : MovieEntity
    
    var body: some View {
        HStack(alignment : .center, spacing : 10) {
            AsyncImageLoader(imageUrl: movieItem.smallCoverImage, width: 40, height: 40, radius: 50)
            
            VStack(alignment : .leading) {
                Text(movieItem.titleLong ?? "")
                    .lineLimit(1)
                    .font(.system(size: 14, weight: .bold))
                
                GenreView(genres: movieItem.genres, fontSize: 8, padding: 0)
            }
        }
    }
}
