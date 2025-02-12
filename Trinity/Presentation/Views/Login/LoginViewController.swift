//
//  LoginViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import UIKit
import AuthenticationServices
import Combine
import Lottie

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    lazy var logoAnimationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.animationSpeed = 1.0
        return view
    }()
    
    lazy var appleButton: ASAuthorizationAppleIDButton = {
        let view = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
        view.addTarget(self, action: #selector(handleAppleLogin), for: .touchDown)
        return view
    }()
    
    // MARK: - LifeCycle
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        observeViewModel()
    }
    
    // MARK: - UI Setup
    private func UISetup() {
        setLayout()
        setAnimation()
    }

    // MARK: - Actions
    @objc private func handleAppleLogin() {
        log("Starting Apple Login Process", level: .info)
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    // MARK: - Navigation
    private func observeViewModel() {
        viewModel.$loginResult
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                // user 필요하면 추가
                guard let self = self, let result = result else { return }
                self.handleLoginResult(result)
            }
            .store(in: &cancellables)
    }

    // MARK: - Method
    private func handleLoginResult(_ result: LoginResult) {
        switch result {
        case .requiresSignup:
            log("Require signup - Move to Signup View", level: .info)
            changeRootToSignup()
            
        case .waitingForApproval:
            log("waiting for approval", level: .info)
    
        case .denied:
            log("Approval Denied", level: .info)
        
        case .success:
            log("Login Success - Move to Main View", level: .info)
        }
    }
//    private func changeRootToMain() {
//        log("Root 변경 - 메인 화면")
//        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
//              let window = sceneDelegate.window else { return }
//
//        let tabBarVC = DIContainer.makeTabBarViewController()
//        let mainNavController = UINavigationController(rootViewController: tabBarVC)
//
//        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            window.rootViewController = mainNavController
//        }, completion: nil)
//    }
    
    private func changeRootToSignup() {
        log("Root changed - Move to Signup View", level: .debug)
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        let diContainer = DIContainer()
        let signupVC = DIContainer.makeAuthViewController(diContainer)
        let signupNavController = UINavigationController(rootViewController: signupVC())

        
        signupNavController.setNavigationBarHidden(true, animated: false)
    
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = signupNavController
        }, completion: nil)
    }
}

// MARK: - Apple Authorization Delegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        log("Apple Login Success", level: .info)
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
           let code = credential.authorizationCode,
           let authorizationCode = String(data: code, encoding: .utf8) {
            log("Authorization Code: \(authorizationCode)", level: .debug)
            viewModel.loginWithApple(authorizationCode: authorizationCode)
        } else {
            log("Failed to generate authorization code.", level: .error)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        log("Failed to login with Apple: \(error.localizedDescription)", level: .error)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
