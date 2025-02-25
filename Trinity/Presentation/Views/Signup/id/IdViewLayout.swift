//
//  IdViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 2/12/25.
//

import Foundation
import UIKit
import SnapKit

extension IdViewController {
    func setLayout() {
        baseView.configure(
            title: "LET'S\nGET STARTED!",
            status: "You can write your ID.",
            progress: 0.48,
            buttonText: "Continue"
        )
        
        baseView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        [subTitleLabel, idTextFieldView, idTextField].forEach {
            baseView.contentView.addSubview($0)
        }
        
        let screenHeight = UIScreen.main.bounds.height
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(screenHeight * 0.04)
            make.leading.equalToSuperview().offset(24)
        }
        
        idTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(screenHeight * 0.015)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(screenHeight * 0.06)
        }
        
        idTextField.snp.makeConstraints { make in
            make.edges.equalTo(idTextFieldView).inset(12)
        }
    }
}
