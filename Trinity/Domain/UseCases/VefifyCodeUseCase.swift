//
//  VerifyCodeUseCase.swift
//  Trinity
//
//  Created by Park Seyoung on 1/11/25.
//

import Foundation
import Combine

final class VerifyCodeUseCase {
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute(phoneNumber: String, code: String) -> AnyPublisher<Void, Error> {
        log("Executing VerifyCodeUseCase with phoneNumber: \(phoneNumber) and code: \(code)", level: .debug)
        return repository.verifyCode(phoneNumber: phoneNumber, code: code)
    }
}

