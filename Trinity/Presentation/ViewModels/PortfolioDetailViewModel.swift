//
//  PortfolioDetailViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 3/16/25.
//

import Combine
import SwiftUI

// 프로토콜 정의 (필요할 경우)
protocol PortfolioDetailViewModelProtocol {
    var image: UIImage? { get set }
    var url: String { get set }
    var title: String { get set }
    var content: String { get set }
    
    func updateTitle(_ title: String)
    func updateContent(_ content: String)
    func saveTitleContents()
}

// ViewModel 선언
final class PortfolioDetailViewModel: ObservableObject, PortfolioDetailViewModelProtocol {
    // MARK: - Published Properties
    @Published var isSaveEnabled: Bool = false
    @Published var isImage: Bool?
    @Published var image: UIImage?
    @Published var url: String = ""
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var status: PortfolioStatus? // 상태 관리
    @Published var errorMessage: String? // 에러 메시지
    
    private var cancellables = Set<AnyCancellable>()
    private let signupViewModel: SignupViewModel
    
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
        self.image = signupViewModel.signupState.portfolioImage
        if let url = signupViewModel.signupState.musicURL {
            self.url = url.absoluteString
        } else {
            self.url = ""
        }
        
        if image == nil {
            isImage = false
        } else {
            isImage = true
        }
    }
    
    // MARK: - Function
    func updateTitle(_ title: String) {
        self.title = title
    }
    
    func updateContent(_ content: String) {
        self.content = content
    }
    
    func saveTitleContents() {
        signupViewModel.updateTitleContents(title, content)
        print("Title: \(title), Content: \(content) 저장 완료!")
    }
}
