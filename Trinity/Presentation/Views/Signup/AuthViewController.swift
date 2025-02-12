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
    
    private let viewModel: AuthViewModelProtocol
    let baseView = SignupBaseView()
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()
    private var phoneNumber: String = ""
    
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
    init(viewModel: AuthViewModelProtocol, diContainer: DIContainer) {
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
    
    //MARK: - setBaseView
    private func bindViewModel() {
        viewModel.statusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (status: AuthStatus) in
                self?.updateButtonUI(for: status)
                
                if case .success = status {
                    self?.navigateToCodeVerification()
                }
            }
            .store(in: &cancellables)
        
        viewModel.errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    PopupManager.shared.showErrorAlert(errorMessage: message, on: self!)
                }
            }
            .store(in: &cancellables)
        
        viewModel.formattedPhoneNumberPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] formattedText in
                self?.phoneTextField.text = formattedText
                let isValid = formattedText.isEmpty ? nil : self?.viewModel.isValidPhoneNumber(formattedText) ?? false
                self?.updatePhoneNumberUI(isValid: isValid)
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - Actions
    @objc func continueTapped() {
        phoneNumber = phoneTextField.text ?? ""
        viewModel.sendVerificationCode(phoneNumber)
    }
    
    // MARK: - Navigation
    private func navigateToCodeVerification() {
        let codeVerificationVC = diContainer.makeCodeVerificationViewController(phoneNumber: phoneNumber)
        navigationController?.pushViewController(codeVerificationVC, animated: true)
    }
    
    // MARK: - UI Helpers
    private func updateButtonUI(for status: AuthStatus) {
        let buttonTitle: String
        let isEnabled: Bool
        
        switch status {
        case .idle:
            buttonTitle = "Enter Code"
            isEnabled = false
        case .loading:
            buttonTitle = "Sending..."
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
    
    func updateButtonAppearance(button: UIButton) {
        button.backgroundColor = button.isEnabled ? .IFBlackSecondary : .IFIvory2
        button.setTitleColor(button.isEnabled ? .IFIvory : .IFTextDis, for: .normal)
    }
    
    private func updatePhoneNumberUI(isValid: Bool?) {
        let borderColor: UIColor
        let textColor: UIColor
        
        if let isValid = isValid {
            borderColor = isValid ? .IFBorderAct : .IFErrorBorder
            textColor = isValid ? .IFBorderAct : .IFErrorText
        } else {
            borderColor = .IFTextInfo
            textColor = .IFBorderAct
        }
        
        phoneTextFieldView.layer.borderColor = borderColor.cgColor
        phoneTextField.textColor = textColor
    }
}

// MARK: - TextField Setting
extension AuthViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newString = currentText.replacingCharacters(in: range, with: string)
        
        let numbersOnly = newString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if numbersOnly.count > 11 { return false }

        if textField.text != numbersOnly { 
            viewModel.updateUserPhoneNumber(numbersOnly)
        }
       
        let isValid: Bool? = numbersOnly.isEmpty ? nil : viewModel.isValidPhoneNumber(numbersOnly)
        updatePhoneNumberUI(isValid: isValid)
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        viewModel.updateUserPhoneNumber("")
        updatePhoneNumberUI(isValid: nil)
        return true
    }
}
