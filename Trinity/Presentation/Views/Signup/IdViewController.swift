//
//  IdViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 2/12/25.
//


import UIKit
import Combine

class IdViewController: UIViewController {
    
    private let viewModel: IdViewModelProtocol
    let baseView = SignupBaseView()
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .IFBorderAct
        label.text = "ID"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var idTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.IFTextInfo.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .left
        textField.textColor = .IFBorderAct
        textField.font = UIFont(name: "Pretendard-Regular", size: 16)
        textField.backgroundColor = .clear
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Ex. aekjngk",
            attributes: [
                .foregroundColor: UIColor.IFTextInfo,
                .font: UIFont(name: "Pretendard-Regular", size: 16)!
            ]
        )
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Initializer
    init(viewModel: IdViewModelProtocol, diContainer: DIContainer) {
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
    
    //MARK: - bindViewModel
    private func bindViewModel() {
        viewModel.statusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.updateButtonUI(for: status)
            }
            .store(in: &cancellables)

        viewModel.idPublisher
            .dropFirst()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] id in
                self?.idTextField.text = id
                let isValid = self?.viewModel.isValidId(id) ?? false
                self?.updateIdUI(isValid: isValid)
            }
            .store(in: &cancellables)

        viewModel.errorMessagePublisher
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                PopupManager.shared.showErrorAlert(errorMessage: errorMessage, on: self!)
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions
    @objc func continueTapped() {
        viewModel.saveId()
        navigateToNextStep()
    }
    
    // MARK: - Navigation
    private func navigateToNextStep() {
        log("Move to next step", level: .info)
        // 다음 VC 이동 코드 추가
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
            buttonTitle = "Checking..."
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
    
    private func updateIdUI(isValid: Bool?) {
        guard let isValid = isValid else { return }
        
        let borderColor: UIColor = isValid ? .IFBorderAct : .IFErrorBorder
        let textColor: UIColor = isValid ? .IFBorderAct : .IFErrorText
        
        UIView.animate(withDuration: 0.15) { 
            self.idTextFieldView.layer.borderColor = borderColor.cgColor
            self.idTextField.textColor = textColor
        }
    }
}

// MARK: - TextField Delegate
extension IdViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.contains(" ") else { return false }
        
        // 입력된 텍스트 업데이트
        guard let currentText = textField.text as NSString? else { return true }
        let newString = currentText.replacingCharacters(in: range, with: string)
        
        viewModel.updateId(newString)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        viewModel.updateId("")
        updateIdUI(isValid: nil)
        return true
    }
}
