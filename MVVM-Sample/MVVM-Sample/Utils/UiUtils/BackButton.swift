//
//  BackButton.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10, height: 20)
                .padding(EdgeInsets(top: 6, leading: 0, bottom: 6, trailing: 6))
                .foregroundColor(Color.black)
        }

    }
}
