//
//  APIResponse.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

enum APIResponse<T: Decodable>: Decodable {
    case success(T)
    case failure(ServerError)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let success = try? container.decode(T.self) {
            self = .success(success)
        } else {
            let failure = try container.decode(ServerError.self)
            self = .failure(failure)
        }
    }
}
