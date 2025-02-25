//
//  InterestsVIewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import Foundation
import UIKit
import SnapKit

extension InterestsViewController {
    func setLayout() {
        baseView.configure(
            title: "CHOOSE YOUR\nINTERESTS!",
            status: "Please select up to five to proceed.",
            progress: 0.88,
            buttonText: "Continue"
        )
        
        baseView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        baseView.contentView.addSubview(categoryCollectionView)
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
    }
}
