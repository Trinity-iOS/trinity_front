//
//  LoginRepositoryProtocol.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginWithApple(authorizationCode: String) async throws -> LoginResponse
}

