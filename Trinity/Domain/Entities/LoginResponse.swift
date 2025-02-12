//
//  LoginResponse.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

enum UserStatus: String, Decodable {
    case pending = "PENDING"
    case rejected = "REJECTED"
    case authorized = "AUTHORIZED"
    case unknown // 예기치 못한 값 처리용
}

struct LoginResponse: Decodable {
    struct UserDetail: Decodable {
        struct User: Decodable {
            let id: Int
            let appleId: String
            let status: UserStatus
        }

        struct Tokens: Decodable {
            let accessToken: String
            let refreshToken: String
        }

        let user: User
        let tokens: Tokens
    }

    let message: String
    let isRegistered: Bool
    let status: UserStatus
    let user: UserDetail
    let error: String?
}
