//
//  AuthRepository.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Foundation
import Combine
import FirebaseAuth

final class AuthRepository: AuthRepositoryProtocol {
    
    // MARK: - 전화번호 인증 요청
    func sendPhoneNumber(phoneNumber: String) -> AnyPublisher<String, Error> { // verificationID 반환
        return Future<String, Error> { promise in
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    log("Failed to send phone number: \(error.localizedDescription)", level: .error)
                    promise(.failure(error))
                    return
                }
                
                if let verificationID = verificationID {
                    Keychain.create(key: "authVerificationID", token: verificationID) // Keychain 저장
                    log("Verification ID saved to Keychain.", level: .debug)
                    promise(.success(verificationID))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - 인증 코드 확인 및 로그인 처리
    func verifyCode(phoneNumber: String, code: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            guard let verificationID = Keychain.read(key: "authVerificationID") else {
                let error = NSError(domain: "VerificationIDNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "Verification ID not found in Keychain."])
                log("Verification ID not found.", level: .error)
                promise(.failure(error))
                return
            }
            
            log("Using verificationID = \(verificationID) for code verification", level: .debug)
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID,
                verificationCode: code
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    log("Verification failed: \(error.localizedDescription)", level: .error)
                    promise(.failure(error))
                } else {
                    log("Verification successful. User signed in.", level: .info)
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
