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
    
    func sendVerificationCode(_ rawPhoneNumber: String)
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
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(sendPhoneNumberUseCase: SendPhoneNumberUseCaseProtocol) {
        self.sendPhoneNumberUseCase = sendPhoneNumberUseCase
    }
    
    // MARK: - Function
    // 사용자가 입력시 실시간 포매팅
    func updateUserPhoneNumber(_ rawInput: String) {
        let formatted = convertPhoneNumber(rawInput, formatted: true)
        formattedPhoneNumber = formatted
        status = isValidPhoneNumber(formatted) ? .ready : .idle
    }
    
    // 전화번호 유효성 검사
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let cleanedNumber = convertPhoneNumber(phoneNumber, formatted: false)
        return cleanedNumber.hasPrefix("010") && cleanedNumber.count == 11
    }
    
    // Firebase에 보낼 전화번호 변환
    func sendVerificationCode(_ rawPhoneNumber: String) {
        let cleanedPhoneNumber = convertPhoneNumber(rawPhoneNumber, formatted: false)
        guard let e164PhoneNumber = convertToE164Format(cleanedPhoneNumber, countryCode: "+82") else {
            errorMessage = "Invalid phone number"
            return
        }
        requestPhoneNumberVerification(phoneNumber: e164PhoneNumber)
    }
    
    // Firebase에 인증 요청
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
    
    // 전화번호 변환 (formatted: true -> 하이픈 포함, false -> 하이픈 없애기)
    private func convertPhoneNumber(_ phoneNumber: String, formatted: Bool) -> String {
        // 불필요한 문자 제거 (숫자만 남기기)
        let numbersOnly = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if !formatted { return numbersOnly } // Firebase 전송용이면 하이픈 제거 후 반환
        
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
    
    // Firebase에 보낼 전화번호 변환
    private func convertToE164Format(_ phoneNumber: String, countryCode: String) -> String? {
        guard phoneNumber.hasPrefix("0") else { return nil }
        let trimmedPhoneNumber = String(phoneNumber.dropFirst())
        return "\(countryCode)\(trimmedPhoneNumber)"
    }
}
