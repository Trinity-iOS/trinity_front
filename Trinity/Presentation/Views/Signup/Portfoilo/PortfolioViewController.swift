//
//  PortfolioViewController.swift
//  Trinity
//
//  Created by Park Seyoung on 2/25/25.
//

import UIKit
import Combine

class PortfolioViewController: UIViewController {
    
    private let viewModel: PortfolioViewModelProtocol
    let baseView = SignupBaseView()
    private let diContainer: DIContainer
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Properties
    lazy var uploadView: UIView = {
        let view = UIView()
        view.backgroundColor = .IFIvory
        view.layer.borderColor = UIColor.IFTextInfo.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    lazy var uploadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var uploadIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UploadIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var expLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textColor = .IFBorderAct
        label.text = "Upload at least 1 works."
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var expSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 10)
        label.textColor = .IFTextInfo
        label.text = "JPG, JPEG, PNG and WBEP formats"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapUploadButton), for: .touchUpInside)
        button.backgroundColor = .clear
        
        return button
    }()
    
    lazy var urlTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 14)
        label.textColor = .IFTextDis
        label.text = "JPG, JPEG, PNG and WBEP formats"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var urlView: UIView = {
        let view = UIView()
        view.backgroundColor = .IFIvory
        view.layer.borderColor = UIColor.IFTextInfo.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    lazy var urlTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .left
        textField.textColor = .IFBorderAct
        textField.font = UIFont(name: "Pretendard-Regular", size: 16)
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(
            string: "music URL",
            attributes: [
                .foregroundColor: UIColor.IFTextInfo,
                .font: UIFont(name: "Pretendard-Regular", size: 16)!
            ]
        )
        textField.delegate = self
        return textField
    }()
    
    lazy var urlUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(.IFTextDis, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 12)
        button.layer.borderColor = UIColor.IFTextInfo.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = .IFIvory2
        button.addTarget(self, action: #selector(didTapURLUploadButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Initializer
    init(viewModel: PortfolioViewModelProtocol, diContainer: DIContainer) {
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
        setupTapGesture()
    }
    
    //MARK: - bindViewModel
    private func bindViewModel() {
        viewModel.statusPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                self?.updateUI(for: status)
            }
            .store(in: &cancellables)
        
        viewModel.errorMessagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] errorMessage in
                if let error = errorMessage {
                    print(errorMessage ?? "")
                }
            }
            .store(in: &cancellables)
        
        viewModel.uploadedURLPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] uploadedURL in
                self?.urlTextField.text = uploadedURL
            }
            .store(in: &cancellables)
        
        viewModel.uploadedImagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] image in
                guard let self = self, let image = image else { return }
                self.uploadImageView.image = image
                self.uploadImageView.isHidden = false
            }
            .store(in: &cancellables)
    }
    

    // MARK: - Actions
    @objc func continueTapped() {
        viewModel.savePortfolio()
        navigateToNextStep()
    }
    
    @objc private func didTapURLUploadButton() {
        guard let text = urlTextField.text, !text.isEmpty else { return }

        // ✅ URL 유효성 검사
        if !viewModel.isValidURL(text) {
            updateUI(for: .urlError) // ❌ URL이 유효하지 않다면 UI 업데이트
            return
        }

        // ✅ URL이 유효하면 저장
        viewModel.uploadURL(text) // ✅ URL 업로드를 호출!
    }

    @objc private func didTapUploadButton() {
        if viewModel.uploadedURL != nil {
            viewModel.clearURLUpload() // ✅ PNG 업로드 시 기존 URL 삭제
        }
        updateUI(for: .idle)

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @objc private func savePortfolio() {
        viewModel.savePortfolio()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    private func navigateToNextStep() {
        log("Move to next step", level: .info)
        let profileVC = diContainer.makeProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    // MARK: - UI Helpers
    private func updateUI(for status: PortfolioStatus?) {
        switch status {
        case .idle:
            configureUploadView(borderColor: .IFTextInfo, imageHidden: true)
            configureURLView(enabled: false)
            updateContinueButton(enabled: false)
            
        case .pngReady:
            configureUploadView(borderColor: .IFBorderAct, imageHidden: false)
            configureURLView(enabled: false)
            updateContinueButton(enabled: true)
            
        case .urlReady:
            configureUploadView(borderColor: .IFTextInfo, imageHidden: true)
            configureURLView(enabled: true)
            updateContinueButton(enabled: false)
            
        case .pngUploaded:
            configureUploadView(borderColor: .IFTextInfo, imageHidden: false)
            configureURLView(enabled: false)
            updateContinueButton(enabled: false)
            
        case .urlUploaded:
            configureUploadView(borderColor: .IFTextInfo, imageHidden: true)
            configureURLView(enabled: false)
            updateContinueButton(enabled: true)
            
        case .urlError:
            configureUploadView(borderColor: .IFTextInfo, imageHidden: true)
            configureValidURLView(isValid: false)
            updateContinueButton(enabled: false)
        
        default:
            configureUploadView(borderColor: .IFTextInfo, imageHidden: true)
            configureURLView(enabled: true)
            updateContinueButton(enabled: false)
        }
    }

    // ✅ 업로드 뷰 스타일 설정
    private func configureUploadView(borderColor: UIColor, imageHidden: Bool) {
        uploadView.layer.borderColor = borderColor.cgColor
        uploadImageView.isHidden = imageHidden
        expLabel.isHidden = !imageHidden
        expSubLabel.isHidden = !imageHidden
        uploadIconImage.isHidden = !imageHidden
    }

    // ✅ URL 뷰 스타일 설정
    private func configureURLView(enabled: Bool) {
        urlView.layer.borderColor = enabled ? UIColor.IFBorderAct.cgColor : UIColor.IFTextInfo.cgColor
        urlUploadButton.isEnabled = enabled
        urlUploadButton.backgroundColor = enabled ? .IFBlackSecondary : .IFIvory2
        urlUploadButton.setTitleColor(enabled ? .IFIvory : .IFTextDis, for: .normal)
    }
    
    private func configureValidURLView(isValid: Bool) {
        urlView.layer.borderColor = isValid ? UIColor.IFBorderAct.cgColor : UIColor.IFErrorBorder.cgColor
        urlTextField.textColor = isValid ? .IFTextDef : .IFErrorText
    }

    // ✅ Continue 버튼 업데이트
    private func updateContinueButton(enabled: Bool) {
        baseView.continueButton.isEnabled = enabled
        baseView.continueButton.backgroundColor = enabled ? .IFBlackSecondary : .IFIvory2
        baseView.continueButton.setTitleColor(enabled ? .IFIvory : .IFTextDis, for: .normal)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - TextField Delegate
extension PortfolioViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard var text = urlTextField.text, !text.isEmpty else {
            updateUI(for: .idle) // ✅ URL 입력 없으면 버튼 비활성화
            return
        }
        
        if viewModel.uploadedImage != nil {
            viewModel.clearImageUpload() // ✅ URL 입력 시 PNG 삭제
        }
        updateUI(for: .urlReady) // ✅ 뭐라도 입력하면 업로드 버튼 활성화
        return
    }
}

extension PortfolioViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // ✅ PNG 선택 시 기존 URL 삭제
            if viewModel.uploadedURL != nil {
                viewModel.clearURLUpload()
                updateUI(for: .idle) // ✅ URL 삭제 후 즉시 UI 반영
            }

            // ✅ 이미지 업로드
            viewModel.uploadImage(selectedImage)
            updateUI(for: .pngUploaded) // ✅ PNG 업로드 상태로 업데이트
        }
        picker.dismiss(animated: true)
    }
}
