//
//  NetworkUtil.swift
//  MVVM-Sample
//
//  Created by 박현우 on 2023/02/04.
//

import Foundation

public enum HTTPMethod : String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

protocol NetworkUtil {
    func sendRequest<T: Decodable>(url: String, method : HTTPMethod, parameters : [URLQueryItem]?) async throws -> T
}

extension NetworkUtil {
    func sendRequest<T: Decodable>(url: String, method : HTTPMethod, parameters : [URLQueryItem]? = nil) async throws -> T {
        
        // info.plist에서 정의한 API 통신을 위한 URL prefix를 불러온다.
        guard let dictionary = Bundle.main.infoDictionary else {
            throw NetworkError.invalidURLError
        }
        
        let baseUrl = dictionary["BASE_URL"] as! String
        
        // BASE_URL과 나머지 URL을 합친다.
        guard var request = URLComponents(string: baseUrl + url) else {
            throw NetworkError.invalidURLError
        }
        
        // 쿼리 파라미터가 필요한 경우 추가한다. 없을경우 기본값을 nil
        if let parameters = parameters {
            request.queryItems = parameters
        }
        
        guard let url = request.url else {
            throw NetworkError.invalidURLError
        }
        
        // 위에서 설정한 정보를 바탕으로 urlRequest 생성
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = method.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noResponseError
            }

            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    throw NetworkError.decodingError
                }
                return decodedResponse
            case 400...499:
                throw NetworkError.badRequestError
            case 500...599 :
                throw NetworkError.serverError
            default:
                throw NetworkError.unknownError
            }
            
        } catch URLError.Code.notConnectedToInternet {
            throw NetworkError.internetConnectionError
        }
    }
}
