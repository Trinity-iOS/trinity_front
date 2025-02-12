//
//  APIClient.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

