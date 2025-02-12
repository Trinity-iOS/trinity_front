//
//  MockLoginRepository.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

final class MockLoginRepository: LoginRepositoryProtocol {
    func loginWithApple(authorizationCode: String) async throws -> LoginResponse {
        return LoginResponse(
            message: "Mock login successful",
            isRegistered: false,
            status: .authorized,
            user: LoginResponse.UserDetail(
                user: LoginResponse.UserDetail.User(
                    id: 1234,
                    appleId: "mock.appleId",
                    status: .authorized
                ),
                tokens: LoginResponse.UserDetail.Tokens(
                    accessToken: "mockAccessToken123",
                    refreshToken: "mockRefreshToken456"
                )
            ),
            error: "Invalid user status"
        )
    }
}


