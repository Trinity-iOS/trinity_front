//
//  SignupCodeVerificationViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import UIKit
import SnapKit
import Combine

class CodeVerificationViewController: UIViewController {
    
    public let baseView = SignupBaseView()
    private let viewModel: CodeVerificationViewModelProtocol
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    lazy var otpInputView: OTPInputView = {
        let view = OTPInputView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    // MARK: - Initializer
    init(viewModel: CodeVerificationViewModelProtocol, diContainer: DIContainer) {
        self.viewModel = viewModel
        self.diContainer = diContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        bindViewModel()
    }
    
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        viewModel.statusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.updateButtonUI(for: status)
            }
            .store(in: &cancellables)

        viewModel.errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let errorMessage = errorMessage else { return }
                PopupManager.shared.showErrorAlert(errorMessage: errorMessage, on: self!)
            }
            .store(in: &cancellables)

        viewModel.isVerifiedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isVerified in
                if isVerified {
                    self?.navigateToSignupIdVC()
                }
            }
            .store(in: &cancellables)

    }
    
    // MARK: - Actions
    @objc func continueTapped() {
        viewModel.verifyCode()
    }
    
    // MARK: - Navigation
    private func navigateToSignupIdVC() {
        log("Move to SignupIdVC", level: .info)
        let idVC = diContainer.makeIdViewController()
        navigationController?.pushViewController(idVC, animated: true)
    }
    
    // MARK: - UI Helpers
    private func updateButtonUI(for status: AuthStatus) {
        let buttonTitle: String
        let isEnabled: Bool

        switch status {
        case .idle:
            buttonTitle = "Continue"
            isEnabled = false
        case .loading:
            buttonTitle = "Verifying..."
            isEnabled = false
        case .success:
            buttonTitle = "Complete!"
            isEnabled = false
        case .ready:
            buttonTitle = "Continue"
            isEnabled = true
        case .failure:
            buttonTitle = "Retry"
            isEnabled = true
        }

        baseView.continueButton.setTitle(buttonTitle, for: .normal)
        baseView.continueButton.isEnabled = isEnabled
        updateButtonAppearance(button: baseView.continueButton)
    }
    
    private func updateButtonAppearance(button: UIButton) {
        button.backgroundColor = button.isEnabled ? .IFBlackSecondary : .IFIvory2
        button.setTitleColor(button.isEnabled ? .IFIvory : .IFTextDis, for: .normal)
    }
}

// MARK: - OTPInputViewDelegate
extension CodeVerificationViewController: OTPInputViewDelegate {
    func didEnterOTP(otp: String) {
        viewModel.updateOTP(otp)
    }
}
