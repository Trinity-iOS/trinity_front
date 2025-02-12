//
//  LoginUseCase.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation

final class LoginUseCase {
    private let loginRepository: LoginRepositoryProtocol

    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    func executeAppleLogin(authorizationCode: String) async throws -> LoginResult {
        let loginResponse = try await loginRepository.loginWithApple(authorizationCode: authorizationCode)
        
        if !(loginResponse.isRegistered) {
            return .requiresSignup
        }
        
        switch loginResponse.status {
        case .pending:
            return .waitingForApproval
        case .authorized:
            return .success(tokens: loginResponse.user.tokens)
        case .rejected:
            return .denied
        default:
            return .waitingForApproval
        }
    }
}

enum LoginResult {
    case requiresSignup
    case waitingForApproval
    case denied
    case success(tokens: LoginResponse.UserDetail.Tokens)
}
