//
//  VerifyCodeUseCase.swift
//  Trinity
//
//  Created by Park Seyoung on 1/11/25.
//

import Combine

protocol VerifyCodeUseCaseProtocol {
    func verifyCode(phoneNumber: String, code: String) -> AnyPublisher<Void, Error>
}

final class VerifyCodeUseCase: VerifyCodeUseCaseProtocol {
    
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: -  인증 코드 확인
    func verifyCode(phoneNumber: String, code: String) -> AnyPublisher<Void, Error> {
        return repository.verifyCode(phoneNumber: phoneNumber, code: code)
    }
}
