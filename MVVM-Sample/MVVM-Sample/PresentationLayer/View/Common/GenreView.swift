//
//  GenreView.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/05.
//

import SwiftUI

struct GenreView: View {
    
    var genres : [String]?
    var fontSize : CGFloat = 12
    var padding : CGFloat = 10
    
    var body: some View {
        HStack(spacing : 5) {
            if let genres = genres {
                ForEach(genres, id : \.self) { genre in
                    Text("#\(genre)")
                        .font(.system(size: fontSize, weight: .bold))
                        .foregroundColor(Color.gray)
                }
            }
        }
        .padding(.horizontal, padding)
    }
}
