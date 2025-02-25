//
//  PorfolioViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 2/25/25.
//

import Foundation
import UIKit
import SnapKit

extension PortfolioViewController {
    func setLayout() {
        baseView.configure(
            title: "UPLOAD YOUR\nPORTFOLIO",
            status: "Please select up to five to proceed.",
            progress: 1.0,
            buttonText: "Continue"
        )
        
        baseView.continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        [uploadView, urlView, urlTitleLabel].forEach {
            baseView.contentView.addSubview($0)
        }
        
        [uploadIconImage, uploadImageView, expLabel, expSubLabel, uploadButton].forEach {
            uploadView.addSubview($0)
        }
        
        [urlTextField, urlUploadButton].forEach {
            urlView.addSubview($0)
        }
        
        let screenHeight = UIScreen.main.bounds.height
        
        uploadView.snp.makeConstraints { make in
            make.top.equalTo(baseView.statusLabel.snp.bottom).offset(screenHeight * 0.04)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(180)
        }
        
        uploadImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        uploadIconImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(48)
            make.top.equalToSuperview().offset(32)
        }
        
        expLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(uploadIconImage.snp.bottom).offset(16)
        }
        
        expSubLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(expLabel.snp.bottom).offset(8)
        }
        
        uploadButton.snp.makeConstraints { make in
            make.edges.equalTo(uploadView)
        }
        
        urlTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(uploadView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(28)
        }
        
        urlView.snp.makeConstraints { make in
            make.top.equalTo(urlTitleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(52)
        }
        
        urlTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        urlUploadButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-14)
            make.width.equalTo(60)
        }
    }
}
