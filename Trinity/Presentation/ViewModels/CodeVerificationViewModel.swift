//
//  CodeVerificationViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine

final class CodeVerificationViewModel: ObservableObject {
    @Published var isCodeValid: Bool = false
    @Published var errorMessage: String?
    @Published var isVerified: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let verifyCodeUseCase: VerifyCodeUseCase
    public let phoneNumber: String
    var code: String = "" {
        didSet {
            isCodeValid = code.count == 6
        }
    }

    init(verifyCodeUseCase: VerifyCodeUseCase, phoneNumber: String) {
        self.verifyCodeUseCase = verifyCodeUseCase
        self.phoneNumber = phoneNumber
    }

    func verifyCode() {
        guard isCodeValid else {
            errorMessage = "Invalid code. Please enter a valid 6-digit code."
            return
        }

        log("Verifying code for phoneNumber: \(phoneNumber)", level: .network)
        verifyCodeUseCase.execute(phoneNumber: phoneNumber, code: code)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    log("Verification failed: \(error.localizedDescription)", level: .error)
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] in
                log("Verification successful", level: .info)
                self?.isVerified = true
            })
            .store(in: &cancellables)
    }
}

