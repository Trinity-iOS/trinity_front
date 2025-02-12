//
//  SendPhoneNumberUseCase.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Combine

protocol SendPhoneNumberUseCaseProtocol {
    func sendPhoneNumber(phoneNumber: String) -> AnyPublisher<String, Error>
}

final class SendPhoneNumberUseCase: SendPhoneNumberUseCaseProtocol {
    
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - 전화번호 인증 요청 (Repository에서 verificationID 반환)
    func sendPhoneNumber(phoneNumber: String) -> AnyPublisher<String, Error> {
        return repository.sendPhoneNumber(phoneNumber: phoneNumber)
    }
}

