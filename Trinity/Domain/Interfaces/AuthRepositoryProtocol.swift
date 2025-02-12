//
//  AuthRepositoryProtocol.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    func sendPhoneNumber(phoneNumber: String) -> AnyPublisher<Void, Error>
    func verifyCode(phoneNumber: String, code: String) -> AnyPublisher<Void, Error>
}
