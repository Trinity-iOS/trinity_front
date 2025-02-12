//
//  NetworkError.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}
