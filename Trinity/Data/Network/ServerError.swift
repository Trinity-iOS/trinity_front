//
//  ServerError.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

struct ServerError: Decodable {
    let statusCode: Int
    let message: String
}
