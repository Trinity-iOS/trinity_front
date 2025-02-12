//
//  IdViewModel.swift
//  Trinity
//
//  Created by Park Seyoung on 2/12/25.
//

import Foundation
import Combine

protocol IdViewModelProtocol {
    var statusPublisher: Published<AuthStatus>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
    var idPublisher: Published<String>.Publisher { get }
    
    func updateId(_ id: String)
    func saveId()
    func isValidId(_ id: String) -> Bool
}

final class IdViewModel: IdViewModelProtocol {
    // MARK: - Published Properties
    @Published private(set) var status: AuthStatus = .idle
    @Published private(set) var errorMessage: String?
    @Published private(set) var id: String = ""
    
    var statusPublisher: Published<AuthStatus>.Publisher { $status }
    var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
    var idPublisher: Published<String>.Publisher { $id }
    
    private let signupViewModel: SignupViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
    }
    
    // MARK: - Function
    func updateId(_ newId: String) {
            id = newId

            if newId.isEmpty {
                status = .idle  
//                errorMessage = nil
                return
            }

            if isValidId(newId) {
                status = .ready
//                errorMessage = nil
            } else {
                status = .idle
//                errorMessage = "ID는 3~15자의 영어 또는 _ 만 허용됩니다."
            }
        }
    
    func isValidId(_ id: String) -> Bool {
        let pattern = "^[a-zA-Z_]{3,15}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: id)
    }
    
    func saveId() {
        guard isValidId(id) else {
            status = .failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "유효하지 않은 ID입니다."]))
            return
        }
        
        signupViewModel.updateID(id)
        status = .success
    }
}
