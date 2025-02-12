//
//  UIButton+.swift
//  Trinity
//
//  Created by Park Seyoung on 1/11/25.
//

import Foundation
import UIKit

extension UIButton {
    func updateAppearance(isEnabled: Bool) {
        self.isEnabled = isEnabled
        if isEnabled {
            self.backgroundColor = .IFBlackSecondary // 활성화 상태
            self.setTitleColor(.IFIvory, for: .normal)
        } else {
            self.backgroundColor = .IFIvory2 // 비활성화 상태
            self.setTitleColor(.IFTextDis, for: .normal)
        }
    }
}
