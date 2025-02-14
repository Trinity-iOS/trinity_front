//
//  DIContainer.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

final class DIContainer {
    private let authRepository: AuthRepositoryProtocol
    
    // 싱글톤
    lazy var signupViewModel: SignupViewModel = {
        return SignupViewModel()
    }()

    init(authRepository: AuthRepositoryProtocol = AuthRepository()) {
        self.authRepository = authRepository
    }

    func makeAuthViewModel() -> AuthViewModel {
        return AuthViewModel(
            signupViewModel: signupViewModel,
            sendPhoneNumberUseCase: makeSendPhoneNumberUseCase()
        )
    }

    func makeCodeVerificationViewModel() -> CodeVerificationViewModel {
        return CodeVerificationViewModel(
            signupViewModel: signupViewModel,
            verifyCodeUseCase: makeVerifyCodeUseCase()
        )
    }
    
    func makeIdViewModel() -> IdViewModel {
        return IdViewModel(
            signupViewModel: signupViewModel
        )
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(
            signupViewModel: signupViewModel
        )
    }

    func makeSignupViewModel() -> SignupViewModel {
        return signupViewModel
    }

    @MainActor static func makeLoginViewController() -> LoginViewController {
        let apiClient = DefaultAPIClient()

//        let loginRepository = LoginRepository(apiClient: apiClient)
        let loginRepository = MockLoginRepository()
        let loginUseCase = LoginUseCase(loginRepository: loginRepository)
        let viewModel = LoginViewModel(signupUseCase: loginUseCase)
        return LoginViewController(viewModel: viewModel)
    }
    
    func makeAuthViewController() -> AuthViewController {
        return AuthViewController(viewModel: makeAuthViewModel(), diContainer: self)
    }

    func makeCodeVerificationViewController() -> CodeVerificationViewController {
        return CodeVerificationViewController(viewModel: makeCodeVerificationViewModel(), diContainer: self)
    }
    
    func makeIdViewController() -> IdViewController {
        return IdViewController(viewModel: makeIdViewModel(), diContainer: self)
    }
    
    func makeProfileViewController() -> ProfileViewController {
        return ProfileViewController(viewModel: makeProfileViewModel(), diContainer: self)
    }

    private func makeSendPhoneNumberUseCase() -> SendPhoneNumberUseCase {
        return SendPhoneNumberUseCase(repository: authRepository)
    }

    private func makeVerifyCodeUseCase() -> VerifyCodeUseCase {
        return VerifyCodeUseCase(repository: authRepository)
    }
}
