//
//  ProfileViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import Foundation
import Combine
import UIKit

protocol profileViewModelProtocol {
    var profileStatusPublisher: Published<ProfileStatus>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var profileImagePublisher: Published<UIImage?>.Publisher { get }
    var bioPublisher: Published<String?>.Publisher { get }
    var isContinueButtonEnabledPublisher: Published<Bool>.Publisher { get }
    
    func selectRandomImage()
    func updateProfileImage(_ Image: UIImage)
    func updateBio(_ bio: String)
    func saveProfileImageBio()
}

final class ProfileViewModel: profileViewModelProtocol {
    // MARK: - Published Properties
    private let maxBioLength = 280
    
    @Published private(set) var profileImage: UIImage?
    @Published private(set) var bio: String?
    @Published private(set) var profileStatus: ProfileStatus = .randomImageSelected
    @Published private(set) var errorMessage: String?
    @Published private(set) var isContinueButtonEnabled: Bool = false
    
    
    var profileImagePublisher: Published<UIImage?>.Publisher { $profileImage }
    var profileStatusPublisher: Published<ProfileStatus>.Publisher { $profileStatus }
    var bioPublisher: Published<String?>.Publisher { $bio }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    var isContinueButtonEnabledPublisher: Published<Bool>.Publisher { $isContinueButtonEnabled }
    
    private let signupViewModel: SignupViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let randomImages: [UIImage] = [
        UIImage(named: "profile0")!,
        UIImage(named: "profile1")!,
        UIImage(named: "profile2")!,
        UIImage(named: "profile3")!,
        UIImage(named: "profile4")!,
        UIImage(named: "profile5")!,
        UIImage(named: "profile6")!,
        UIImage(named: "profile7")!,
        UIImage(named: "profile8")!,
        UIImage(named: "profile9")!,
        UIImage(named: "profile10")!,
        UIImage(named: "profile11")!
    ]
    
    // MARK: - Init
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
        selectRandomImage()
    }
    
    // MARK: - Function
    func selectRandomImage() {
        profileImage = randomImages.randomElement()
        profileStatus = .randomImageSelected
    }
    
    func updateProfileImage(_ image: UIImage) {
        profileImage = image
        profileStatus = .userImageSelected
    }
    
    func updateBio(_ bio: String) {
        guard self.bio != bio else { return }
        self.bio = bio
        profileStatus = bio.count > maxBioLength ? .bioTooLong : .bioValid
        updateButtonState()
    }
    
    func saveProfileImageBio() {
        guard (profileImage != nil) else {
            errorMessage = "Please select a profile image."
            return
        }
        
        guard (bio != nil) else {
            errorMessage = "Please enter the bio"
            return
        }
        
        signupViewModel.updateProfileImage(profileImage)
        log("save profileImage \(profileImage!)", level: .info)
        
        signupViewModel.updateBio(bio)
        log("save bio: \(String(describing: bio))", level: .info)
        
        profileStatus = .success
    }
    
    private func updateButtonState() {
        let isImageSelected = profileImage != nil
        let isBioValid = profileStatus == .bioValid
        let previousState = isContinueButtonEnabled
        isContinueButtonEnabled = isImageSelected && isBioValid
        
        if previousState != isContinueButtonEnabled {
            print("🔹 [DEBUG] 버튼 활성화 상태 변경됨: \(isContinueButtonEnabled)")
        }
    }

}
