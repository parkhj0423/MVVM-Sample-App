//
//  AsyncImageLoader.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct AsyncImageLoader: View {
    
    var imageUrl : String?
    var width : CGFloat = .infinity
    var height : CGFloat = 300
    var radius : CGFloat = 0
    
    var body: some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(maxWidth : width, maxHeight : height, alignment: .center)
                    .cornerRadius(radius)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth : width, minHeight : height, alignment: .center)
            }
        }
    }
}
