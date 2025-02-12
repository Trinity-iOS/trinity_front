//
//  SignupViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 2/12/25.
//

import Foundation
import Combine
import UIKit

final class SignupViewModel {
    @Published private(set) var signupState: SignupState
    
    init(signupState: SignupState = SignupState()) {
        self.signupState = signupState
    }
    
    func updateCountry(_ country: String?) {
        signupState.country = country
    }
    
    func updatePhoneNumber(_ phoneNumber: String?) {
        signupState.phoneNumber = phoneNumber
    }
    
    func updateID(_ id: String?) {
        signupState.id = id
    }
    
    func updatePassword(_ password: String?) {
        signupState.password = password
    }
    
    func updateProfileImage(_ image: UIImage?) {
        signupState.profileImage = image
    }
    
    func updateBio(_ bio: String?) {
        signupState.bio = bio
    }
    
    // 이차원 배열
    func updateInterests(_ interests: [[String]]?) {
        signupState.interests = interests
    }
    
    func updatePortfolioImage(_ image: UIImage?) {
        signupState.portfolioImage = image
    }
    
    func updateMusicURL(_ url: URL?) {
        signupState.musicURL = url
    }
}

