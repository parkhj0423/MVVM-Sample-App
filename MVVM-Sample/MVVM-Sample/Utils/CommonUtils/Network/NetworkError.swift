//
//  NetworkError.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public enum NetworkError: Error {
    case decodingError
    case invalidURLError
    case noResponseError
    case serverError
    case badRequestError
    case internetConnectionError
    case unknownError

    var errorMessage: String {
        switch self {
        case .decodingError :
            return "Decoding Error"
        case .invalidURLError :
            return "Invalid URL"
        case .noResponseError :
            return "No Response"
        case .serverError :
            return "Server Error"
        case .badRequestError :
            return "Bad Request From Client"
        case .internetConnectionError :
            return "Internet Connection is unstable"
        default:
            return "Unknown Error"
        }
    }
}
