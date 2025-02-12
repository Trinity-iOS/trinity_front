//
//  LoginRepository.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

final class LoginRepository: LoginRepositoryProtocol {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func loginWithApple(authorizationCode: String) async throws -> LoginResponse {
        let endpoint = Endpoint(
            path: "/auth/login/apple",
            method: .POST,
            queryParameters: nil,
            body: try JSONSerialization.data(withJSONObject: ["authorizeCode": authorizationCode], options: []),
            headers: ["Content-Type": "application/json"]
        )

        return try await withCheckedThrowingContinuation { continuation in
            apiClient.request(endpoint: endpoint) { (result: Result<LoginResponse, NetworkError>) in
                switch result {
                case .success(let authResponse):
                    log("Login with apple API Success: \(authResponse)", level: .debug)
                    continuation.resume(returning: authResponse)
                case .failure(let error):
                    log("Login to server API Failed: \(error)", level: .error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
