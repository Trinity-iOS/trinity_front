//
//  ProfileViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    private let viewModel: profileViewModelProtocol
    let baseView = SignupBaseView()
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Properties
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapChangeButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plusButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .IFBorderAct
        label.text = "Bio"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var bioTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.IFTextInfo.cgColor
        view.layer.borderWidth = 1.0
        
        return view
    }()
    
    lazy var bioTextField: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
        textView.textColor = .IFBorderAct
        textView.font = UIFont(name: "Pretendard-Regular", size: 16)
        textView.delegate = self
        
        return textView
    }()
    
    // MARK: - Initialize
    init(viewModel: profileViewModelProtocol, diContainer: DIContainer) {
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
        viewModel.profileImagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] image in
                self?.profileImageView.image = image
            }
            .store(in: &cancellables)

        viewModel.profileStatusPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                switch status {
                case .randomImageSelected:
                    log("random Image Selected", level: .info)
                case .userImageSelected:
                    log("USer Image Selected", level: .info)
                case .bioValid:
                    log("bio valid", level: .info)
                    self?.updateIdUI(isValid: true)
                case .bioTooLong:
                    self?.updateIdUI(isValid: false)
                default:
                   break
                }
            }
            .store(in: &cancellables)
        
        viewModel.isContinueButtonEnabledPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] isEnabled in
                self?.baseView.continueButton.isEnabled = isEnabled
                self?.updateButtonAppearance(button: self?.baseView.continueButton ?? UIButton())
            }
            .store(in: &cancellables)
        
        viewModel.bioPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] bio in
                log("biobio", level: .info)
                self?.bioTextField.text = bio
            }
            .store(in: &cancellables)
    }

    // MARK: - Actions
    @objc func continueTapped() {
        viewModel.saveProfileImageBio()
        navigateToNextStep()
    }
    
    @objc private func didTapChangeButton() {
        viewModel.selectRandomImage()
    }
    
    @objc private func didTapAddButton() {
        presentImagePicker()
    }
    
    @objc private func didChangeBio() {
        viewModel.updateBio(bioTextField.text ?? "")
    }
    
    private func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    // MARK: - Navigation
    private func navigateToNextStep() {
        log("Move to next step", level: .info)
        let interestVC = diContainer.makeInerestViewController()
        navigationController?.pushViewController(interestVC, animated: true)
    }
    
    
    // MARK: - UI Helpers
    private func updateButtonAppearance(button: UIButton) {
        button.backgroundColor = button.isEnabled ? .IFBlackSecondary : .IFIvory2
        button.setTitleColor(button.isEnabled ? .IFIvory : .IFTextDis, for: .normal)
    }
    
    //Bio field랑 연결 Status - bio too long 이면 ?
    private func updateIdUI(isValid: Bool?) {
        guard let isValid = isValid else { return }
        
        let borderColor: UIColor = isValid ? .IFBorderAct : .IFErrorBorder
        let textColor: UIColor = isValid ? .IFBorderAct : .IFErrorText
        
        UIView.animate(withDuration: 0.15) {
            self.bioTextFieldView.layer.borderColor = borderColor.cgColor
            self.bioTextField.textColor = textColor
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            viewModel.updateProfileImage(selectedImage)
        }
        picker.dismiss(animated: true)
    }
}

extension ProfileViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.updateBio(textView.text ?? "")
    }
}
