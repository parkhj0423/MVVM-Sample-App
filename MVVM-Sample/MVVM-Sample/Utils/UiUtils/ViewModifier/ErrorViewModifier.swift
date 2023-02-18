//
//  ErrorViewModifier.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation
import SwiftUI

struct ErrorViewModifier : ViewModifier {
    
    var error : NetworkError?
    var refresh : () -> Void
    
    @State private var isPresent : Bool = false
    
    func body(content: Content) -> some View {
        VStack {
            if let error = error {
                errorView(error: error)
            } else {
                content
            }
        }
            .onChange(of: error) { networkError in
                if networkError != nil {
                    return self.isPresent = true
                }
                
                return self.isPresent = false
            }
            .alert(error?.errorMessage ?? "", isPresented: self.$isPresent, actions: {
                Button("ok", role: .cancel) {
                    self.isPresent = false
                }
            })
    }
    
    private func errorView(error : NetworkError) -> some View {
        VStack(spacing : 20) {
            Text(error.errorMessage)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.black)
            
            Button {
                refresh()
            } label: {
                Text("Retry")
                    .frame(width: 40, height: 20)
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .font(.system(size: 13))
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(4)
            }
        }
    }
    
    
    private func isError() -> Bool {
        return error != nil
    }
}
