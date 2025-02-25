//
//  PortfolioViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 2/25/25.
//

import Foundation
import Combine
import UIKit

protocol PortfolioViewModelProtocol {
    var statusPublisher: Published<PortfolioStatus?>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var uploadedURLPublisher: Published<String?>.Publisher { get }
    var uploadedImagePublisher: Published<UIImage?>.Publisher { get }
    
    var uploadedImage: UIImage? { get }
    var uploadedURL: String? { get }
    
    func uploadURL(_ text: String)
    func uploadImage(_ image: UIImage)
    func clearImageUpload()
    func clearURLUpload()
    func savePortfolio()
    func isValidURL(_ url: String) -> Bool
}


final class PortfolioViewModel: PortfolioViewModelProtocol {
    @Published private(set) var status: PortfolioStatus? = .idle
    @Published private(set) var errorMessage: String?
    @Published private(set) var uploadedURL: String? = nil
    @Published private(set) var uploadedImage: UIImage? = nil
    
    var statusPublisher: Published<PortfolioStatus?>.Publisher { $status }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    var uploadedURLPublisher: Published<String?>.Publisher { $uploadedURL }
    var uploadedImagePublisher: Published<UIImage?>.Publisher { $uploadedImage }
    
    private let signupViewModel: SignupViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
    }
    
    // ✅ URL 업로드 완료 처리
    func uploadURL(_ url: String) {
        guard isValidURL(url) else {
            errorMessage = "Invalid URL format."
            return
        }
        
        // ✅ 기존 PNG 삭제 (URL 입력 시)
        if uploadedImage != nil {
            clearImageUpload()
        }
        
        uploadedURL = url // ✅ URL을 바로 업데이트!
        status = .urlUploaded
    }
    
    /// ✅ 이미지 업로드
    func uploadImage(_ image: UIImage) {
        if uploadedURL != nil {
            clearURLUpload() // ✅ URL이 업로드된 상태라면 URL 삭제
        }
        
        uploadedImage = image
        status = .pngReady
    }
    
    /// ✅ 이미지 업로드 완료 처리
    func finalizeImageUpload() {
        guard uploadedImage != nil else {
            errorMessage = "No image uploaded."
            return
        }
        
        status = .pngUploaded
    }
    
    /// ✅ 업로드된 PNG 제거
    func clearImageUpload() {
        uploadedImage = nil
        status = .idle
    }
    
    /// ✅ 업로드된 URL 제거
    func clearURLUpload() {
        uploadedURL = nil
        status = .idle
    }
    
    // ✅ 포트폴리오 저장 (PNG 또는 URL 중 하나가 있어야 저장 가능)
    func savePortfolio() {
        guard status == .pngUploaded || status == .urlUploaded else {
            errorMessage = "Please upload a valid file (PNG or URL)."
            return
        }
        
        status = .completed
        errorMessage = nil
    }
    
    // ✅ URL 유효성 검사
    func isValidURL(_ url: String) -> Bool {
        guard let url = URL(string: url) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
}
