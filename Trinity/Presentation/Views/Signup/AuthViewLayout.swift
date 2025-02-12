//
//  AuthViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 2/12/25.
//

import Foundation
import UIKit

extension AuthViewController {
    func setLayout() {
        baseView.configure(
            title: "LET'S\nGET STARTED!",
            status: "We will send you\n4 digits verification code.",
            progress: 0.33,
            buttonText: "Continue"
        )
        
        baseView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
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
}
