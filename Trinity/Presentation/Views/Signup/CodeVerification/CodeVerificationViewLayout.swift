//
//  CodeVerificationViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import Foundation
import UIKit
import SnapKit

extension CodeVerificationViewController {
    func setLayout() {
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
}
