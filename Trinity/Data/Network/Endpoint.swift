//
//  Endpoint.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryParameters: [String: String]?
    let body: Data?
    let headers: [String: String]?

    func url(baseURL: String) -> URL? {
        guard var components = URLComponents(string: baseURL + path) else {
            print("❌ [Endpoint] 유효하지 않은 Base URL 또는 Path: \(baseURL + path)")
            return nil
        }

        if let queryParameters = queryParameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        if let url = components.url {
            print("✅ [Endpoint] 생성된 URL: \(url.absoluteString)")
            return url
        } else {
            print("❌ [Endpoint] URLComponents에서 URL 생성 실패")
            return nil
        }
    }
}

