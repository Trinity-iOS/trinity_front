//
//  SignupPhoneAuthViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine

protocol AuthViewModelProtocol {
    var statusPublisher: Published<AuthStatus>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var formattedPhoneNumberPublisher: Published<String>.Publisher { get }
    
    func sendVerificationCode()
    func updateUserPhoneNumber(_ rawInput: String)
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool
}

final class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: - Published Properties
    @Published private(set) var status: AuthStatus = .idle
    @Published private(set) var errorMessage: String?
    @Published private(set) var formattedPhoneNumber: String = ""
    
    var statusPublisher: Published<AuthStatus>.Publisher { $status }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    var formattedPhoneNumberPublisher: Published<String>.Publisher { $formattedPhoneNumber }
    
    private let sendPhoneNumberUseCase: SendPhoneNumberUseCaseProtocol
    private let signupViewModel: SignupViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(signupViewModel: SignupViewModel ,sendPhoneNumberUseCase: SendPhoneNumberUseCaseProtocol) {
        self.signupViewModel = signupViewModel
        self.sendPhoneNumberUseCase = sendPhoneNumberUseCase
    }
    
    // MARK: - Function
    func updateUserPhoneNumber(_ rawInput: String) {
        let formatted = formatPhoneNumber(rawInput)
        formattedPhoneNumber = formatted
        
        let isValid = isValidPhoneNumber(formatted)
        status = isValid ? .ready : .idle
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let cleanedNumber = removeHyphens(phoneNumber)
        return cleanedNumber.hasPrefix("010") && cleanedNumber.count == 11
    }
    
    func sendVerificationCode() {
        let cleanedPhoneNumber = removeHyphens(formattedPhoneNumber)
        
        // 하이픈 뺀 전화번호 저장
        signupViewModel.updatePhoneNumber(removeHyphens(formattedPhoneNumber))
        
        guard isValidPhoneNumber(cleanedPhoneNumber) else {
            errorMessage = "Invalid phone number"
            return
        }
        
        guard let e164PhoneNumber = convertToE164Format(cleanedPhoneNumber, countryCode: "+82") else {
            errorMessage = "Invalid phone number format"
            return
        }
        
        requestPhoneNumberVerification(phoneNumber: e164PhoneNumber)
    }
    
    private func requestPhoneNumberVerification(phoneNumber: String) {
        status = .loading
        
        sendPhoneNumberUseCase.sendPhoneNumber(phoneNumber: phoneNumber)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.status = .failure(error)
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] verificationID in
                Keychain.create(key: "authVerificationID", token: verificationID)
                self?.status = .success
            }
            .store(in: &cancellables)
    }
    
    // MARK: - 전화번호 변환 로직
    private func removeHyphens(_ phoneNumber: String) -> String {
        return phoneNumber.replacingOccurrences(of: "-", with: "")
    }

    private func formatPhoneNumber(_ phoneNumber: String) -> String {
        let numbersOnly = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        if numbersOnly.count <= 3 {
            return numbersOnly
        } else if numbersOnly.count <= 7 {
            let prefix = String(numbersOnly.prefix(3))
            let suffix = String(numbersOnly.suffix(numbersOnly.count - 3))
            return "\(prefix)-\(suffix)"
        } else {
            let prefix = String(numbersOnly.prefix(3))
            let middle = String(numbersOnly.prefix(7).suffix(4))
            let suffix = String(numbersOnly.suffix(numbersOnly.count - 7))
            return "\(prefix)-\(middle)-\(suffix)"
        }
    }

    private func convertToE164Format(_ phoneNumber: String, countryCode: String) -> String? {
        guard phoneNumber.hasPrefix("0") else { return nil }
        let trimmedPhoneNumber = String(phoneNumber.dropFirst())
        return "\(countryCode)\(trimmedPhoneNumber)"
    }
}
