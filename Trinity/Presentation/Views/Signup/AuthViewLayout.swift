//
//  AuthViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import UIKit
import SnapKit

extension AuthViewController {
    func setLayout() {
        view.backgroundColor = .IFBgDef
        
        [roundedBackgroundView, progressBar, titleLabel, statusLabel, subTitleLabel,phoneTextFieldView, phoneTextField, continueButton].forEach {
            view.addSubview($0)
        }
        
        let screenHeight = UIScreen.main.bounds.height
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenHeight * 0.14)
            make.height.equalTo(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(screenHeight * 0.05)
            make.leading.equalToSuperview().offset(24)
        }
        
        roundedBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(screenHeight * 0.04)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(roundedBackgroundView.snp.top).offset(screenHeight * 0.03)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(screenHeight * 0.04)
            make.leading.equalToSuperview().offset(24)
        }
        
        phoneTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(screenHeight * 0.015)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(screenHeight * 0.06)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(screenHeight * 0.015)
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalToSuperview().offset(-44)
            make.centerY.equalTo(phoneTextFieldView.snp.centerY)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(screenHeight * 0.06))
            make.height.equalTo(screenHeight * 0.07)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
