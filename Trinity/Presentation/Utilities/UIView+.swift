//
//  UIView+.swift
//  Trinity
//
//  Created by Park Seyoung on 1/10/25.
//

import UIKit

extension UIView {
    func applyRoundedCorners(cornerRadius: CGFloat, corners: CACornerMask) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = corners
        self.clipsToBounds = true
    }
}
