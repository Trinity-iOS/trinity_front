//
//  DIContainer.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Foundation

final class DIContainer {
    @MainActor static func makeLoginViewController() -> LoginViewController {
        let apiClient = DefaultAPIClient()

//        let loginRepository = LoginRepository(apiClient: apiClient)
        let loginRepository = MockLoginRepository()
        let loginUseCase = LoginUseCase(loginRepository: loginRepository)
        let viewModel = LoginViewModel(signupUseCase: loginUseCase)
        return LoginViewController(viewModel: viewModel)
    }
    
    private let authRepository: AuthRepositoryProtocol
    
    init(authRepository: AuthRepositoryProtocol = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    func makeSignupPhoneAuthViewController() -> AuthViewController {
        let repository = AuthRepository()
        let useCase = SendPhoneNumberUseCase(repository: repository)
        let viewModel = AuthViewModel(sendPhoneNumberUseCase: useCase)
        return AuthViewController(viewModel: viewModel, diContainer: self)
    }

    
    func makeCodeVerificationViewController(phoneNumber: String) -> CodeVerificationViewController {
        // authrepository 주입 문제 ㅠ
        let authRepository = AuthRepository()
        let verifyCodeUseCase = VerifyCodeUseCase(repository: authRepository)
        let viewModel = CodeVerificationViewModel(verifyCodeUseCase: verifyCodeUseCase, phoneNumber: phoneNumber)
        return CodeVerificationViewController(viewModel: viewModel)
    }
    
    //    static func makeTabBarViewController() -> TabBarViewController {
    //        // 각 탭에 필요한 ViewController 생성
    //        let homeVC = makeHomeViewController()
    //        let discoverVC = makeDiscoverViewController()
    //        let boardVC = makeBoardViewController()
    //        let myPageVC = makeMyPageViewController()
    //
    //        // TabBarViewController 생성 및 DI
    //        return TabBarViewController(
    //            homeVC: homeVC,
    //            discoverVC: discoverVC,
    //            boardVC: boardVC,
    //            myPageVC: myPageVC
    //        )
    //    }
    //
    //    // HomeViewController 생성
    //    private static func makeHomeViewController() -> UIViewController {
    //        let viewModel = HomeViewModel() // 필요하면 UseCase를 DI
    //        return HomeViewController(viewModel: viewModel)
    //    }
    //
    //    // DiscoverViewController 생성
    //    private static func makeDiscoverViewController() -> UIViewController {
    //        let viewModel = DiscoverViewModel() // 필요하면 UseCase를 DI
    //        return DiscoverViewController(viewModel: viewModel)
    //    }
    //
    //    // BoardViewController 생성
    //    private static func makeBoardViewController() -> UIViewController {
    //        let viewModel = BoardViewModel() // 필요하면 UseCase를 DI
    //        return BoardViewController(viewModel: viewModel)
    //    }
    //
    //    // MyPageViewController 생성
    //    private static func makeMyPageViewController() -> UIViewController {
    //        let viewModel = MyPageViewModel() // 필요하면 UseCase를 DI
    //        return MyPageViewController(viewModel: viewModel)
    //    }
}
