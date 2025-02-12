//
//  LoginAnimation.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import Lottie

extension LoginViewController {
    func setAnimation() {
        logoAnimationView.animation = LottieAnimation.named("Logo Animation Image")
        logoAnimationView.play()
    }
}
