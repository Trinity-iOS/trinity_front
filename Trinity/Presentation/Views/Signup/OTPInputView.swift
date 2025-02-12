//
//  OTPInputView.swift
//  Trinity
//
//  Created by Park Seyoung on 1/11/25.
//

import UIKit
import SnapKit

protocol OTPInputViewDelegate: AnyObject {
    func didEnterOTP(otp: String)
}

class OTPInputView: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    weak var delegate: OTPInputViewDelegate?
    private let stackView = UIStackView()
    private var textFields: [UITextField] = []
    private let numberOfDigits = 6
    private let defaultUnderlineColor = UIColor.gray
    private let activeUnderlineColor = UIColor.black
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setupView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        for index in 0..<numberOfDigits {
            let textField = createTextField(tag: index)
            textFields.append(textField)
            stackView.addArrangedSubview(textField)
        }
        
        textFields.first?.becomeFirstResponder()
    }
    
    private func createTextField(tag: Int) -> UITextField {
        let textField = UITextField()
        textField.tag = tag
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        textField.delegate = self
        
        let underlineView = UIView()
        underlineView.backgroundColor = defaultUnderlineColor
        underlineView.tag = 100
        textField.addSubview(underlineView)
        
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return textField
    }
    
    // MARK: - UITextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil else { return false }
        
        let currentIndex = textField.tag
        if !string.isEmpty {
            textField.text = string
            updateUnderline(for: textField, color: activeUnderlineColor)
            
            let nextIndex = currentIndex + 1
            if nextIndex < numberOfDigits {
                textFields[nextIndex].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        } else {
            textField.text = ""
            updateUnderline(for: textField, color: defaultUnderlineColor)
            
            let previousIndex = currentIndex - 1
            if previousIndex >= 0 {
                textFields[previousIndex].becomeFirstResponder()
            }
        }
        
        notifyDelegate()
        return false
    }
    
    private func updateUnderline(for textField: UITextField, color: UIColor) {
        if let underlineView = textField.viewWithTag(100) {
            underlineView.backgroundColor = color
        }
    }
    
    private func notifyDelegate() {
        let otp = textFields.compactMap { $0.text }.joined()
        delegate?.didEnterOTP(otp: otp)
    }
}

