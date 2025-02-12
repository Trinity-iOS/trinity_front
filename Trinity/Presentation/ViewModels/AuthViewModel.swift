//
//  SignupPhoneAuthViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine
import FirebaseAuth

final class AuthViewModel {
    
    enum Status {
        case idle
        case loading
        case success
        case failure(Error)
    }
    
    @Published var phoneNumber: String?
    @Published var status: Status = .idle
    @Published var errorMessage: String?
    
    private let sendPhoneNumberUseCase: SendPhoneNumberUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(sendPhoneNumberUseCase: SendPhoneNumberUseCase) {
        self.sendPhoneNumberUseCase = sendPhoneNumberUseCase
    }
    
    func sendPhoneNumber(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        status = .loading
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.status = .failure(error)
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            if let verificationID = verificationID {
                Keychain.create(key: "authVerificationID", token: verificationID)
                log("verificationId saved", level: .debug)
                DispatchQueue.main.async {
                    self.status = .success
                }
            }
        }
    }
}

