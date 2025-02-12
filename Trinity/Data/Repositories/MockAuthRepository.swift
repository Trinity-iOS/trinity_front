//
//  MockAuthRepository.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine

final class MockAuthRepository: AuthRepositoryProtocol {
    func sendPhoneNumber(phoneNumber: String) -> AnyPublisher<Void, Error> {
        // Mock API Response
        Future<Void, Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                if phoneNumber.starts(with: "010") && phoneNumber.count == 11 {
                    promise(.success(()))
                } else {
                    promise(.failure(NSError(domain: "InvalidPhoneNumber", code: 400, userInfo: nil)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func verifyCode(phoneNumber: String, code: String) -> AnyPublisher<Void, Error> {
        // Mock API Response
        Future<Void, Error> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                // Assume the correct code is "1234"
                if code == "1234" {
                    promise(.success(()))
                } else {
                    promise(.failure(NSError(domain: "InvalidCode", code: 401, userInfo: nil)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
