//
//  LoginViewLayout.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit
import SnapKit

extension LoginViewController {
    func setLayout() {
        view.backgroundColor = UIColor.IFBgDef
        
        view.addSubview(logoAnimationView)
        view.addSubview(appleButton)
        
        let height = UIScreen.main.bounds.height
        
        logoAnimationView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(height * 0.35)
            make.centerX.equalToSuperview()
            make.height.equalTo(height * 0.1)
        }
        
        appleButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(height * 0.2))
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }
    }
}
