//
//  ProfileViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import Foundation
import UIKit
import SnapKit

extension ProfileViewController {
    func setLayout() {
        baseView.configure(
            title: "TELL US ABOUT\nYOURSELF",
            status: "You can always add or update\nyour phone later.",
            progress: 0.66,
            buttonText: "Continue"
        )
        
        baseView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        [profileImageView, changeButton, addButton, subTitleLabel, bioTextFieldView, bioTextField].forEach {
            baseView.contentView.addSubview($0)
        }
        
        let screenHeight = UIScreen.main.bounds.height
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(screenHeight * 0.06)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(screenHeight * 0.18)
        }
        
        changeButton.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(screenHeight * 0.06)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(screenHeight * 0.18)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(screenHeight * 0.044)
            make.trailing.equalToSuperview().offset( -(screenHeight * 0.12))
            make.width.height.equalTo(screenHeight * 0.056)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(screenHeight * 0.048)
            make.leading.equalToSuperview().offset(24)
        }
        
        bioTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(screenHeight * 0.015)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(screenHeight * 0.146)
        }
        
        bioTextField.snp.makeConstraints { make in
            make.edges.equalTo(bioTextFieldView).inset(12)
        }
    }
}
