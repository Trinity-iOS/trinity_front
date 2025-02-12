//
//  SignupBaseView.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import UIKit
import SnapKit

class SignupBaseView: UIView {
    
    // MARK: - Common Properties
    let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.tintColor = .IFIvory2
        progress.trackTintColor = .IFBorderAct
        progress.layer.cornerRadius = 2
        progress.clipsToBounds = true
        return progress
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .IFIvory
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 14)
        label.textColor = .IFBorderDef
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        let screenHeight = UIScreen.main.bounds.height
        view.backgroundColor = .IFIvory
        view.applyRoundedCorners(cornerRadius: screenHeight * 0.1, corners: [.layerMinXMinYCorner])
        return view
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 24)
        button.isEnabled = false
        
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI setup
    private func UISetup() {
        backgroundColor = .IFBgDef
        addSubview(progressBar)
        addSubview(titleLabel)
        addSubview(roundedBackgroundView)
        addSubview(statusLabel)
        addSubview(continueButton)
        addSubview(contentView)
        
        let screenHeight = UIScreen.main.bounds.height
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
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
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(roundedBackgroundView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(screenHeight * 0.06))
            make.height.equalTo(screenHeight * 0.07)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
    // MARK: - Configuration Methods
    func configure(title: String, status: String, progress: Float, buttonText: String) {
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Moderniz", size: 20)
        statusLabel.text = status
        progressBar.progress = progress
        continueButton.setTitle(buttonText, for: .normal)
    }
}
