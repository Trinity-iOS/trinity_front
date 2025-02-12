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
    
    private let viewModel: CodeVerificationViewModel
    public let baseView = SignupBaseView()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    private lazy var otpInputView: OTPInputView = {
        let view = OTPInputView(frame: .zero)
        view.delegate = self
        return view
    }()
    
    // MARK: - Initializer
    init(viewModel: CodeVerificationViewModel) {
        self.viewModel = viewModel
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
        setupUI()
        bindViewModel()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        baseView.configure(
            title: "VERIFICATION\nCODE",
            status: "Enter the 6-digit verification code\nsent to your phone.",
            progress: 0.33,
            buttonText: "Verify"
        )
        
        baseView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        baseView.continueButton.updateAppearance(isEnabled: false)
        
        baseView.contentView.addSubview(otpInputView)
        
        otpInputView.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    @objc private func continueTapped() {
        viewModel.verifyCode()
    }
    
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        viewModel.$isCodeValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.baseView.continueButton.updateAppearance(isEnabled: isValid)
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let errorMessage = errorMessage else { return }
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellables)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - OTPInputViewDelegate
extension CodeVerificationViewController: OTPInputViewDelegate {
    func didEnterOTP(otp: String) {
        viewModel.code = otp
    }
}
