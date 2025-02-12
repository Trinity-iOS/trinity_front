//
//  CustomTabBar.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit

class CustomTabBar: UITabBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.performWithoutAnimation {
            var tabFrame = self.frame
            let height = UIScreen.main.bounds.height * 0.1
            tabFrame.size.height = height
            tabFrame.origin.y = UIScreen.main.bounds.height - height
            self.frame = tabFrame
        }
    }
}

