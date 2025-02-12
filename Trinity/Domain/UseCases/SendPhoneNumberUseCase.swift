//
//  SendPhoneNumberUseCase.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine

final class SendPhoneNumberUseCase {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(phoneNumber: String) -> AnyPublisher<Void, Error> {
        repository.sendPhoneNumber(phoneNumber: phoneNumber)
    }
}
