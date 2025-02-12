//
//  CodeVerificationViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine

protocol CodeVerificationViewModelProtocol {
    var statusPublisher: Published<AuthStatus>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var isVerifiedPublisher: Published<Bool>.Publisher { get }
    var otpCodePublisher: Published<String>.Publisher { get }
    
    func updateOTP(_ otp: String)
    func verifyCode()
}

final class CodeVerificationViewModel: CodeVerificationViewModelProtocol {
    
    // MARK: - Published Properties
    @Published private(set) var status: AuthStatus = .idle
    @Published private(set) var errorMessage: String?
    @Published private(set) var isVerified: Bool = false
    @Published private(set) var otpCode: String = ""
    
    var statusPublisher: Published<AuthStatus>.Publisher { $status }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    var isVerifiedPublisher: Published<Bool>.Publisher { $isVerified }
    var otpCodePublisher: Published<String>.Publisher { $otpCode }
    
    private let signupViewModel: SignupViewModel
    private var cancellables = Set<AnyCancellable>()
    private let verifyCodeUseCase: VerifyCodeUseCaseProtocol
    
    // MARK: - Init
    init(signupViewModel: SignupViewModel, verifyCodeUseCase: VerifyCodeUseCaseProtocol) {
        self.signupViewModel = signupViewModel
        self.verifyCodeUseCase = verifyCodeUseCase
    }
    
    // MARK: - OTP 입력 업데이트
    func updateOTP(_ code: String) {
        otpCode = code
        status = otpCode.count == 6 ? .ready : .idle
    }
    
    // MARK: - OTP 검증
    func verifyCode() {
        guard otpCode.count == 6 else {
            errorMessage = "Invalid code. Please enter a valid 6-digit code."
            return
        }
        
        log("Verifying code for phoneNumber: \(String(describing: signupViewModel.signupState.phoneNumber))", level: .network)
        status = .loading
        
        verifyCodeUseCase.verifyCode(phoneNumber: signupViewModel.signupState.phoneNumber ?? "", code: otpCode)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    log("Verification failed: \(error.localizedDescription)", level: .error)
                    self?.status = .failure(error)
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] in
                log("Verification successful", level: .info)
                self?.status = .success
                self?.isVerified = true
            }
            .store(in: &cancellables)
    }
}

