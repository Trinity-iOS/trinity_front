//
//  PickProfileImageViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 2/14/25.
//

import Foundation
import Combine
import UIKit

protocol profileViewModelProtocol {
    var statusPublisher: Published<AuthStatus>.Publisher { get }
    var profileImageStatusPublisher: Published<ImageSelectionStatus>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var profileImagePublisher: Published<UIImage>.Publisher { get }
    var bioPublisher: Published<String>.Publisher { get }
    
    func selectRandomImage()
    func updateProfileImage(_ Image: UIImage)
}

final class ProfileViewModel: profileViewModelProtocol {
    // MARK: - Published Properties
    
