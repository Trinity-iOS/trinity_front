//
//  SignupViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var user: LoginResponse.UserDetail?
    @Published var loginResult: LoginResult?
    
    private let loginUseCase: LoginUseCase
    
    init(signupUseCase: LoginUseCase) {
        self.loginUseCase = signupUseCase
    }
    
    func loginWithApple(authorizationCode: String) {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let result = try await loginUseCase.executeAppleLogin(authorizationCode: authorizationCode)
                
                DispatchQueue.main.async {
                    switch result {
                    case .requiresSignup:
                        self.errorMessage = "Sign-up is required"
                        self.loginResult = .requiresSignup
                        
                    case .waitingForApproval:
                        self.errorMessage = "Your Account is under review"
                        self.loginResult = .waitingForApproval
                    
                    case .denied:
                        self.errorMessage = "Your Account was denied"
                        self.loginResult = .denied
                        
                    case .success(let tokens) :
                        self.errorMessage = nil
                        self.loginResult = .success(tokens: tokens)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}
