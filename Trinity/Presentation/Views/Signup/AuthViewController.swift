//
//  AuthViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import UIKit
import SnapKit
import Combine
import Firebase

class AuthViewController: UIViewController {
    
    private let viewModel: AuthViewModel
    public let baseView = SignupBaseView()
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .IFBorderAct
        label.text = "Mobile Number"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var phoneTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.IFTextInfo.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .left
        textField.textColor = .IFBorderAct
        textField.font = UIFont(name: "Pretendard-Regular", size: 16)
        textField.backgroundColor = .clear
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Ex. 01012345678",
            attributes: [
                .foregroundColor: UIColor.IFTextInfo,
                .font: UIFont(name: "Pretendard-Regular", size: 16)!
            ]
        )
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Initializer
    init(viewModel: AuthViewModel, diContainer: DIContainer) {
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
        UISetup()
        bindViewModel()
    }
    
    // MARK: - UI Setup
    private func UISetup() {
        configureView()
        setupAdditionalLayout()
    }
    
    private func configureView() {
        baseView.configure(
            title: "LET'S\nGET STARTED!",
            status: "We will send you\n4 digits verification code.",
            progress: 0.33,
            buttonText: "Continue"
        )
        
        baseView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        updateButtonAppearance(button: baseView.continueButton)
    }
    
    private func setupAdditionalLayout() {
        [subTitleLabel, phoneTextFieldView, phoneTextField].forEach {
            baseView.contentView.addSubview($0)
        }
        
        let screenHeight = UIScreen.main.bounds.height
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(screenHeight * 0.04)
            make.leading.equalToSuperview().offset(24)
        }
        
        phoneTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(screenHeight * 0.015)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(screenHeight * 0.06)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.edges.equalTo(phoneTextFieldView).inset(12)
        }
    }
    
    // MARK: - Actions
    @objc private func continueTapped() {
        guard let rawPhoneNumber = phoneTextField.text else { return }
        
        let cleanedPhoneNumber = rawPhoneNumber.replacingOccurrences(of: "-", with: "")
    
        let e164PhoneNumber = formatToE164(phoneNumber: cleanedPhoneNumber, countryCode: "+82")
        
        if e164PhoneNumber == nil {
            return
        }
        
        viewModel.sendPhoneNumber(phoneNumber: e164PhoneNumber!)
    }
    
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        // 상태 변경에 따른 UI 업데이트
        viewModel.$status
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .idle:
                    break
                case .loading:
                    log("Sending Auth Code...", level: .debug)
                    self?.baseView.continueButton.setTitle("Sending...", for: .normal)
                case .success:
                    log("Success! Move to codeVC", level: .debug)
                    self?.navigateToCodeVerification()
                    self?.baseView.continueButton.setTitle("Complete!", for: .normal)
                case .failure:
                    log("Sending Failed!", level: .error)
                    self?.baseView.continueButton.setTitle("Retry", for: .normal)
                }
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
    
    
    // MARK: - Navigation
    private func navigateToCodeVerification() {
        guard let phoneNumber = viewModel.phoneNumber else {
            log("Error: Phone number is nil", level: .error)
            return
        }

        let codeVerificationVC = diContainer.makeCodeVerificationViewController(phoneNumber: phoneNumber)
        navigationController?.pushViewController(codeVerificationVC, animated: true)
    }
    
    // MARK: - Helper
    private func updatePhoneNumberUI(isValid: Bool) {
        let borderColor: UIColor = isValid ? .IFBorderAct : .IFErrorBorder
        let textColor: UIColor = isValid ? .IFBorderAct : .IFErrorText
        phoneTextFieldView.layer.borderColor = borderColor.cgColor
        phoneTextField.textColor = textColor
        
        baseView.continueButton.isEnabled = isValid
        updateButtonAppearance(button: baseView.continueButton)
    }
    
    private func updateButtonAppearance(button: UIButton) {
        if button.isEnabled {
            button.backgroundColor = .IFBlackSecondary
            button.setTitleColor(.IFIvory, for: .normal)
        } else {
            button.backgroundColor = .IFIvory2
            button.setTitleColor(.IFTextDis, for: .normal)
        }
    }
    
    private func formatToE164(phoneNumber: String, countryCode: String) -> String? {
        guard phoneNumber.hasPrefix("0") else { return nil }
        let trimmedPhoneNumber = String(phoneNumber.dropFirst())
        return "\(countryCode)\(trimmedPhoneNumber)"
    }
}

// MARK: - TextField Setting
extension AuthViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newString = currentText.replacingCharacters(in: range, with: string)
        
        let numbersOnly = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if numbersOnly.count > 11 { return false }
        
        let isValid = numbersOnly.hasPrefix("010") && numbersOnly.count == 11
        
        let formattedNumber = formatPhoneNumber(numbersOnly)
        textField.text = formattedNumber
        
        updatePhoneNumberUI(isValid: isValid)
        
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // ClearButton이 눌리면 텍스트를 비우고 버튼 상태를 비활성화로 업데이트
        textField.text = ""
        updatePhoneNumberUI(isValid: false)
        return true // 기본 클리어 버튼 동작 수행
    }
    
    private func formatPhoneNumber(_ number: String) -> String {
        if number.count <= 3 {
            return number
        } else if number.count <= 7 {
            let prefix = String(number.prefix(3))
            let suffix = String(number.suffix(number.count - 3))
            return "\(prefix)-\(suffix)"
        } else {
            let prefix = String(number.prefix(3))
            let middle = String(number.prefix(7).suffix(4))
            let suffix = String(number.suffix(number.count - 7))
            return "\(prefix)-\(middle)-\(suffix)"
        }
    }
}
